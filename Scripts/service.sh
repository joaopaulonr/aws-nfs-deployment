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
echo "/srv/nfs/joaopaulonr 172.21.0.0/24(rw,subtree_check,sync,root_squash,no_all_squash)" >> /etc/exports
exportfs -rv

#Script para a validação dos dados.
cat <<EOF > validacao_service.sh
#!/bin/bash
#Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'
while true; do
    systemctl status nginx.service > status.txt
    STATUS=\$(cat status.txt | grep "Active:" | awk '{print \$3}' | tr -d '()')
    NGINX_UPTIME=\$(cat status.txt | grep "Active:" | awk '{print \$9}')
    if [ "\$STATUS" = "running" ]; then
        LOGFILE=/srv/nfs/joaopaulonr/\$(date '+%d-%m-%Y_%T')_UP.log
        echo -e "Informações coletadas em: \${BLUE}[\$(date '+%d/%m/%Y %T')]\${NC}." >> "\$LOGFILE"
        echo -e "Tempo ativo: \${GREEN}\$NGINX_UPTIME\${NC}." >> "\$LOGFILE"
        echo -e "Serviço: \${BLUE}[NGINX]\${NC}." >> "\$LOGFILE"
        echo -e "Status: \${GREEN}[\$STATUS]\${NC}." >> "\$LOGFILE"
        echo -e "\${GREEN}O serviço está rodando perfeitamente!\${NC}" >> "\$LOGFILE"
    else
        LOGFILE=/srv/nfs/joaopaulonr/\$(date '+%d-%m-%Y_%T')_DOWN.log
        echo -e "Informações coletadas em: \${BLUE}[\$(date '+%d/%m/%Y %T')]\${NC}." >> "\$LOGFILE"
        echo -e "Tempo fora do ar: \${RED}\$NGINX_UPTIME\${NC}." >> "\$LOGFILE"
        echo -e "Serviço: \${BLUE}[NGINX]\${NC}." >> "\$LOGFILE"
        echo -e "Status: \${RED}[\$STATUS]\${NC}." >> "\$LOGFILE"
        echo -e "\${RED}O serviço está fora do ar!\${NC}" >> "\$LOGFILE"
        echo " " >> "\$LOGFILE"
        systemctl status nginx.service -l --full >> "\$LOGFILE"
    fi
    sleep 300
done
EOF
mv validacao_service.sh /srv/LinuxService
chmod +x /srv/LinuxService/validacao_service.sh

#Serviço para verficação cíclica.
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
