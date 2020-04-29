#!/bin/bash
# Fernando A. Ribeiro Fortes
# Sistema de envio de mensagens
# Objetivos : Trocar Fita DAT da Gravadora
#
# Detalhando...
# são [ 12 ] fitas a serem trocadas as trocas
# são feitas as quartas-feiras, há um  job de
# envio de mensagem agendado via crontab as
# tercas-feiras por volta das  22:30
# há contador para que toda vez que rodar o script
# buscar  numero da execucao anteriore e acrescenta
# mais 1 e grava como atual usando o numero correto
# da fita da jto da notificacao

# Declarando variaveis
GetNum='0' # zerando variaveis com contadores
vlratual='0' # zerando variaveis com contadores
PutNum='/home/maclink/numatual.txt' # arquivo para variacao de fitas
GetNum=`cat /home/maclink/numatual.txt` # pega numero da execucao anterior
vlratual=$(($GetNum+1)) # adiciona mais 1
servidor_email='177.70.110.120'
porta_servidor_email='587'
remetente_email='admredes@sindipraticossp.com.br'
corpo_email="Bom dia.\n\n\nHoje devera ser colocada a fita da semana [$vlratual]\nObs: Verificar se a unidade de fita esta solicitando a fita de limpeza.\n\n\n\nObrigado\nRodrigo Duarte."
assunto_email='BACKUP - TROCAR FITA . . . '
destinatario_email='fernando@oficinapc.com.br'
#destinatario_email='suporte@santospilots.com.br'

enviaMail() {
		sendEmail -s $servidor_email:$porta_servidor_email -f "$remetente_email" -t "$destinatario_email" -u "$assunto_email" -m "$corpo_email" -xu "$remetente_email" -xp 392rd594
}

# rotina para verificar se o arquivo de contagem existe
if [ ! -d $PutNum ]; then
     echo '0' > $PutNum
fi

# Testa valor se maior que 12 volta pra 00
if [[ $vlratual -gt "11" ]]; then
      enviaMail
      echo '0' > /home/maclink/numatual.txt
 else
      echo $vlratual > /home/maclink/numatual.txt
      enviaMail
fi
exit 0
