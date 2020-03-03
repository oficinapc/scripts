#!/bin/bash
# script de backup completo
# routerboard 3011 mikrotik
# autor : Fernando Fortes

# declarando variaveis
data=$(date +%d-%m-%Y) # definindo o formato da data
rbmain='192.168.4.1' # ip do roteador
usuario='maclink' # usuario que pode realizar o backup
porta='2222' # porta configurada no servico ssh do mikrotik
folderbkp='/home/maclink/mkt_backup' # diretorio local que sera armazenado o backup

# verifica se o diretorio existe se nao cria
if [ ! -d $folderbkp ]; then
	    mkdir -p $folderbkp
    fi

    # gerando o backup apos acesso ao mikrotik
    ssh -Cv -l $usuario $rbmain -p $porta \
    /system backup save name=$rbmain.$data.backup \

    # baixando o backup gerado anteriormente
    sftp -P $porta $usuario@$rbmain:*.backup
    mv *.backup $folderbkp

echo "Done."
exit 0

