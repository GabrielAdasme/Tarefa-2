#!/bin/bash

# Script para conectar em banco de dados MYSQL e realizar operacoes de GRANT ou REVOKE.

# Como utilizar o script 
	# ./seuscript usuario localhost(IP) nomedabase -grant 'GRANT ALL PRIVILEGES ON * . *'
	# ./seuscript usuario localhost(IP) nomedabase -revoke 'REVOKE UPDATE ON * . *'
	# OBS: Nao esquece de abrir '' ao inciar GRANT OU REVOKE.
  # Criar um arquivo com usuario e senha adm do db. (#userdb #passdb)
  
#Arquivo de usuario e senha de um administrador do banco de dados
#userdb
#passdb
source senha.txt

clear

#Variaveis
USER=${1:-"usuario"}
HOST=${2:-"host"}
DB=${3:-"banco"}
VAR1=${4:-"variavel1"}
VAR2=${5:-"variavel2"}

echo -e "\nConectando a database $DB...\n"
sleep 3
echo -e "\nExecutando a query: $VAR1 $VAR2\n"
sleep 3

# operacao for -gran sera executada
if [ $VAR1 = "-grant" ]; then

    echo -e "\nScript sendo executado em $DB...\n"
    echo
    sleep 3
    #conexao com o db
    mysql -u $userdb -p$passdb -e "$VAR2 TO '$USER'@'$HOST'"$DB
    #atualizar tb de privileges
    mysql -u $userdb -p$passdb -e "flush privileges" $DB


    if [ $? = "0" ]; then
        echo -e "\nScript executado com sucesso!\n"
        sleep 3
        exit 1 
    else
        echo -e "\nProblema em executar a query!"
        sleep 3
        exit 1
    fi

fi

# caso comando for -revoke operacao sera executada
if [ $VAR1 = "-revoke" ]; then

    echo -e "\nScript sendo execudato em  $DB...\n"
    echo
    mysql -u $userdb -p$passdb -e "$VA2 FROM '$USER'@'$HOST'" $DB
    mysql -u $userdb -p$passdb -e "flush privileges" $DB


    if [ $? = "0" ]; then
        echo -e "\nScrip executado com sucesso!\n"
        sleep 3 
        exit 1
    else
        echo -e "\nErro em realizar a operacao"
        sleep 3
        exit 1
    fi

fi
