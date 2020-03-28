#!/bin/bash
# Fernando A. Ribeiro Fortes
# Sistema de envio de mensagens
# Objetivos : Trocar Fita DAT da Gravadora
#
# Detalhando...
# sao [ 12 ] fitas a serem trocadas as trocas
# sao feitas as quartas-feiras, ha um  job de
# envio de mensagem agendado via crontab as
# tercas-feiras por volta das  22:30
# ha contador para que toda vez que rodar o script
# buscar  numero da execucao anteriore e acrescenta
# mais 1 e grava como atual usando o numero correto
# da fita da jto da notificacao

# Declarando variaveis
getnum=`cat numatual.txt`  # pega numero da execucao anterior
vlratual=$(($getnum+1)) # adiciona mais 1
servidor_email='177.7.11.129'
porta_servidor_email='587'
remetente_email='admredes@dominio.com.br'
corpo_email="Bom dia.\n\n\nHoje devera ser colocada a fita da semana [$vlratual]\nObs: Verificar se a unidade de fita esta solicitando a fita de limpeza.\n\n\n\nObrigado\nRodrigo Duarte."
assunto_email='BACKUP - TROCAR FITA . . . '
destinatario_email="suporte@dominio.com.br"

enviaMail() {
	sendEmail -s $servidor_email:$porta_servidor_email -f "$remetente_email" -t "$destinatario_email" -u "$assunto_email" -m "$corpo_email" -xu "$remetente_email" -xp 392rd594
}

# Testa valor se maior que 12 volta pra 00
if [[ $vlratual -gt "11" ]]; then
     enviaMail
     echo '0' > numatual.txt
  else
     echo $vlratual > numatual.txt
      enviaMail
fi
exit 0
