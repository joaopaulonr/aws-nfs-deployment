#!/bin/bash
#Script para instalar nginx, NFS e configurar os serviços.

#Configurações do sistema
timedatectl set-timezone America/Fortaleza
mkdir /srv/LinuxService
mkdir /srv/LinuxService/Logs

#instalação ,inicialização e ativação do NGINX.
amazon-linux-extras install nginx1 -y
systemctl start nginx.service
systemctl enable nginx.service

#instalação ,inicialização e ativação do NFS.
yum -y install nfs-utils
systemctl start nfs
systemctl enable nfs

#Configuração do NFS

#script para a validação dos dados
cat <<EOF > validacao_service.sh
#!/bin/bash
while true; do
systemctl status nginx.service > status.txt
STATUS=\$(cat status.txt | grep "Active:" | awk '{print \$3}' | tr -d '()')
LOGFILE=/srv/LinuxService/Logs/\$(date '+%d-%m-%Y_%T').txt
NGINX_UPTIME=\$(cat status.txt | grep "Active:" | awk '{print \$9}')
echo "Informações coletadas em: [\$(date '+%d/%m/%Y %T')]." >> "\$LOGFILE"
if [ "\$STATUS" = "running" ]; then
    echo "Tempo ativo: \$NGINX_UPTIME." >> "\$LOGFILE"
    echo "Serviço: NGINX Status:[\$STATUS]" >> "\$LOGFILE"
    echo "O serviço está rodando perfeitamente!" >> "\$LOGFILE"
else
    echo "Tempo fora do ar: \$NGINX_UPTIME." >> "\$LOGFILE"
    echo "Serviço: NGINX Status:[\$STATUS]" >> "\$LOGFILE"
    echo "O serviço está fora do ar!" >> "\$LOGFILE"
fi
sleep 300
done
EOF
mv validacao_service.sh /srv/LinuxService
chmod +x /srv/LinuxService/validacao_service.sh

#script para a criação do serviço para verficação cíclica.
cat <<EOF > updown.service
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
#Inicialização do serviço
mv updown.service /etc/systemd/system
systemctl enable updown.service
systemctl start updown.service