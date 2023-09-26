#!/bin/bash
#Script para instalar nginx, NFS e configurar os serviços.

#Configurações do sistema
timedatectl set-timezone America/Fortaleza

#instalação ,inicialização e ativação do serviço.
amazon-linux-extras install nginx1
systemctl start nginx.service
systemctl enable nginx.service

#script para a validação dos dados
cat <<EOF > validacao_service.sh
#!/bin/bash
while true
do
systemctl status nginx.service > status.txt
STATUS=$(cat status.txt | tr "(" ":" | tr ")" ":" | cut -d ":" -f 3 | sed -n '3p')
echo "Informacoes coletadas em: [$(date '+%d/%m/%Y %T')]." >> "$(date '+%d-%m-%Y_%T').txt"
if [ "$STATUS" = "running" ]; then
    echo "Tempo ativo: $(cat status.txt | cut -d ":" -f 4 | cut -c 8-50 | sed -n '3p')." >> "$(date '+%d-%m-%Y_%T').txt"
    echo "Serviço: NGINX Status:[$STATUS]" >> "$(date '+%d-%m-%Y_%T').txt"
    echo "O serviço está rodando perfeitamente!" >> "$(date '+%d-%m-%Y_%T').txt"
else
    echo "Tempo fora do ar: $(cat status.txt | cut -d ":" -f 4 | cut -c 8-50 | sed -n '3p')." >> "$(date '+%d-%m-%Y_%T').txt"
    echo "Serviço: NGINX Status:[$STATUS]" >> "$(date '+%d-%m-%Y_%T').txt"
    echo "O serviço está fora do ar!" >> "$(date '+%d-%m-%Y_%T').txt"
fi
sleep 300
done
EOF

#script para a criação do serviço para verficação cíclica.
cat <<EOF > updown.service

EOF