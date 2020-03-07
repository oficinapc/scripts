#!/bin/bash
# script de backup completo
# routerboard 3011 mikrotik
# autor : Fernando Fortes
# versao : 1.0
# data : 07-03-2020

# declarando variaveis
# variaveis globais usadas no sistema
# de backups do mikrotik 
data=$(date +%d-%m-%Y) # definindo o formato da data
rbmain='192.168.4.1' # ip do roteador
usuario='maclink' # usuario que pode realizar o backup
porta='2222' # porta configurada no servico ssh do mikrotik
folderbkp='/home/maclink/mkt_backup' # diretorio local que sera armazenado o backup

# Funcao : cria diretorio 
# esse sera o diretorio onde ficara 
# armazenado do arquivo de backup
# do roteador principal da Litoral 

criadir {
# verifica se o diretorio existe se nao cria
if [ ! -d $folderbkp ]; then
	    mkdir -p $folderbkp
    fi
 }

# Funcao : checa routerboard 
# verifica se o router esta respondendo
# antes mesmo de iniciar a copia deve-se
# checar se o roteador esta respondendo
# pois mesmo ligado pode estar travado

rbup {
vld=`ping -w2 -c3 $rbmain` 2&>-
  if [ vld eq 0 ]; then
       echo "A RBMain nao respondeu a ICMP ping..." > ~maclink/errnorb.txt
       exit 0
    fi
 }   

    # Gerando o Backup dentro a RBMMain   
    # apos acesso ao mikrotik o arquivo de 
    # backup e gerado e nomeado 
    ssh -Cv -l $usuario $rbmain -p $porta \
    /system backup save name=$rbmain.$data.backup \

    # Baixando o backup gerado anteriormente
    # remotamente para dentro do servidor Linux
    sftp -P $porta $usuario@$rbmain:*.backup
    mv *.backup $folderbkp
    
echo "Done."
criadir
rbup
exit 0
