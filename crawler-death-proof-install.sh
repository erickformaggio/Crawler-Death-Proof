#!/bin/bash
# Crawler-Death-Proof-install.sh
#
# Versão 1: Instalando Crawler Death Proof e requisitos.
#
# GreenMind,08 Outubro de 2016
#


#+---------------------------------------------------------+
#Constantes HELP e MAN
#+---------------------------------------------------------+

MAN="

$HELP
Manual completo do $(basename "$0")
-h, --help		Comando para exibir ajuda em caso de duvidas.
-m, --man		Manual completo sobre o programa $(basename "$0")
-V, --version		Mostra a versão atual do programa $(basename "$0")


-i, --install		Instala tudo necessario para instalar e usar o Crawler Death Proof.

"

HELP="

Uso: $(basename "$0") [OPÇÕES]
OPÇÕES:
$(basename "$0") Chama o help para Crawler Death Proof

-m, --man		Manual do Programa
-h, --help		Ajuda do Programa
-V, --version 		Versão do Programa

-i, --install		Instalação do necessario para Crawler Death Proof

"

#+---------------------------------------------------------+
#Funções
#+---------------------------------------------------------+

#Manual
function man(){
	echo -e "$MAN";
	exit 0
}

#Help
function help(){
	echo -e "$HELP";
	exit 0
}

#Version
function version(){
	echo -n $(basename "$0")
	# Extrai a versão diretamente dos cabeçalhos do programa
	grep '^# Versão ' "$0" | tail -1 | cut -d : -f 1 | tr -d \#
	exit 0
}

#Install
function install(){
	#Instalação do Crawler Death Proof

	#Atualizando o sistema
	apt-get -y update
	apt-get -y upgrade

	#Instalando o DIG
	apt-get install dnsutils

	#Instalando WHOIS
	apt-get install whois

	#Instalando o NIKTO
	apt-get install nikto

	#Instalando o theharvester
	apt-get install theharvester

	#Instalando o NMAP
	apt-get install nmap

	#Instalando wpscan
	apt-get install wpscan

	#Download Crawler Death Proof
	wget -c https://raw.githubusercontent.com/greenmind-sec/Crawler-Death-Proof-/master/crawler-death-proof

	#Configurando Crawler Death Proof
	chmod +x crawler-death-proof

	#Movendo o Crawler Death Proof para /bin
	mv crawler-death-proof /bin/crawler-death-proof

	#Local onde vai ficar os arquivos de LOG
	mkdir /opt/crawler-death-proof

	clear
	echo "O Crawler Death Proof foi instalado com sucesso!"
}





while test -n "$1"
do
	case "$1" in

    #Manual
		-m | --man)
			man
		;;

		#Ajuda
		-h | --help)
			help
		;;

    #Versão atual do programa
		-V | --version)
			version
		;;

		#Instala o Crawler Death Proof
		-i | --install)
			install
		;;

		*)
			echo Opção inválida: $1
			exit 1
		;;
	esac

	# Opção $1 já processada, a fila deve andar
	shift
done

#Caso não escolha nada chama a função HELP
 help
