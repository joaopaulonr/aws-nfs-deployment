# Atividade Linux
A primeira atividade de um ciclo de sprints em preparação para DevSecOps,a atividade visa aplicar os conhecimentos previamente adquiridos durante as duas primeiras sprints, que abordaram temas relacionados à AWS (Amazon Web Services) e ao sistema operacional Linux.

## Requisitos para a Atividade.

### Requisitos AWS:
- Gerar uma chave pública para acesso ao ambiente.
- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD).
- Gerar 1 elastic IP e anexar à instância EC2.
- Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

### Requisitos no Linux:
- Configurar o NFS entregue.
- Criar um diretório dentro do filesystem do NFS com seu nome.
- Subir um servidor Apache no servidor - o Apache deve estar online e rodando.
- Criar um script que valide se o serviço está online e envie o resultado da validação para o seu diretório no NFS.
- O script deve conter:
  - Data e hora.
  - Nome do serviço.
  - Status (ONLINE ou OFFLINE).
  - Mensagem personalizada.
- O script deve gerar 2 arquivos de saída: 1 para o serviço online e 1 para o serviço OFFLINE.
- Preparar a execução automatizada do script a cada 5 minutos.
- Fazer o versionamento da atividade.

## Cenário de implementação.
<img src="assets/Cenário.svg" alt="cenário de implementação na numvem aws.">

## Desenvolvimento da atividade.
