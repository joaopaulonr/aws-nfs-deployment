#!/bin/bash
#Atividade - Linux
#Script para instalar nginx, NFS e configurar os serviços.

#Configurações do sistema.
yum update -y
timedatectl set-timezone America/Fortaleza
mkdir /srv/LinuxService
mkdir /srv/nfs
mkdir /srv/nfs/joaopaulonr

#Instalação ,inicialização e ativação do NGINX.
amazon-linux-extras install nginx1 -y
systemctl start nginx.service
systemctl enable nginx.service

#Instalação ,inicialização e ativação do NFS.
yum -y install nfs-utils
systemctl start nfs
systemctl enable nfs

#Configuração do NFS.
chmod -R /srv/nfs/joaopaulonr
chown nfsnobody:nfsnobody /srv/nfs/joaopaulonr
echo "/srv/nfs/joaopaulonr 172.21.0.0/24(rw,wdelay,hide,no_subtree_check,sec=sys,sync,secure,root_squash,no_all_squash)" >> /etc/exports
exportfs -rv

#Script para a validação dos dados.
cat <<EOF > validacao_service.sh
#!/bin/bash
while true; do
    systemctl status nginx.service > status.txt
    STATUS=\$(cat status.txt | grep "Active:" | awk '{print \$3}' | tr -d '()')
    NGINX_UPTIME=\$(cat status.txt | grep "Active:" | awk '{print \$9}')
    if [ "\$STATUS" = "running" ]; then
        LOGFILE=/srv/nfs/joaopaulonr/\$(date '+%d-%m-%Y_%T')_UP.txt
        echo "Informações coletadas em: [\$(date '+%d/%m/%Y %T')]." >> "\$LOGFILE"
        echo "Tempo ativo: \$NGINX_UPTIME." >> "\$LOGFILE"
        echo "Serviço: NGINX Status:[\$STATUS]" >> "\$LOGFILE"
        echo "O serviço está rodando perfeitamente!" >> "\$LOGFILE"
    else
        LOGFILE=/srv/nfs/joaopaulonr/\$(date '+%d-%m-%Y_%T')_DOWN.txt
        echo "Informações coletadas em: [\$(date '+%d/%m/%Y %T')]." >> "\$LOGFILE"
        echo "Tempo fora do ar: \$NGINX_UPTIME." >> "\$LOGFILE"
        echo "Serviço: NGINX Status:[\$STATUS]" >> "\$LOGFILE"
        echo "O serviço está fora do ar!" >> "\$LOGFILE"
        echo " " >> "\$LOGFILE"
        systemctl status nginx.service -l --full >> "\$LOGFILE"
    fi
    sleep 300
done
EOF
mv validacao_service.sh /srv/LinuxService
chmod +x /srv/LinuxService/validacao_service.sh

#Script para a criação do serviço para verficação cíclica.
cat <<EOF > upordown.service
[Unit]
Description=NginxData - Informações sobre o serviço do NGINX.
After=network.target
StartLimitIntervalSec=0
[Service]
Type=simple
Restart=always
RestartSec=1
ExecStart=/srv/LinuxService/validacao_service.sh
[Install]
WantedBy=multi-user.target
EOF

#Inicialização do serviço.
mv upordown.service /etc/systemd/system
systemctl enable upordown.service
systemctl start upordown.service
