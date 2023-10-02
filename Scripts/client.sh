#!/bin/bash
#Configurações do sistema.
timedatectl set-timezone America/Fortaleza
mkdir /home/ec2-user/shared

#Instalação do cliente NFS.
yum -y update 
yum -y install nfs-utils
systemctl start nfs
systemctl enable nfs

#Script para o mount do diretório compartilhado.
cat <<EOF > mount.sh
#!/bin/bash 
mount -t nfs [IP_DO_SERVIDOR]:/srv/nfs/joaopaulonr ~/shared
EOF
mv mount.sh /home/ec2-user
chmod +x /home/ec2-user/mount.sh
