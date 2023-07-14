#!/bin/bash
# variaveis

art1=( \
".====,          " \
"||              " \
"||              " \
"||________   o  " \
"||       || /|\ " \
"||       || / \ " )
art2=( \
".====,          " \
"||     o        " \
"||    /|\       " \
"||____/_\_      " \
"||       ||     " \
"||       ||     " )
art3=( \
".====,          " \
"||   'o         " \
"||   /|\        " \
"||___/_\__      " \
"||       ||     " \
"||       ||     " )
art4=( \
".====,          " \
"||   'o         " \
"||   /|\        " \
"||_  / \ _      " \
"|| \    /||     " \
"||       ||     " )
art5=( \
".====,          " \
"||   |          " \
"||   'O         " \
"||_  /|\ _      " \
"|| \ / \/||     " \
"||       ||     " )
telaGanho=( \
"#==================VELHA FORCA==================#\n
#             (>ºº)> VOCE GANHO <(ºº<)          #\n
#                   PONTOS:$pontos${c:$((21+${#pontos}))}#\n
#    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          #\n
#    ░░░░ ░░░░▀█▄▀▄▀██████░▀█▄▀▄▀████▀          #\n
#    ░░░ ░░░░░░░▀█▄█▄███▀░░░▀██▄█▄█▀            #\n
#                                               #\n
#                         ☺                     #\n
#                        /|\\                    #\n
#                        / \\                    #\n
#===============================================#" \

"#==================VELHA FORCA==================#\n
#             V(ºº)> VOCE GANHO v(ºº<)          #\n
#                   PONTOS:$pontos${c:$((21+${#pontos}))}#\n
#    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          #\n
#    ░░░░ ░░░░▀█▄▀▄▀██████░▀█▄▀▄▀████▀          #\n
#    ░░░ ░░░░░░░▀█▄█▄███▀░░░▀██▄█▄█▀            #\n
#                        \\☺/                    #\n
#                         |                     #\n
#                        / \\                    #\n
#                                               #\n
#===============================================#" \

"#==================VELHA FORCA==================#\n
#             (>ºº)> VOCE GANHO <(ºº<)          #\n
#                   PONTOS:$pontos${c:$((21+${#pontos}))}#\n
#    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          #\n
#    ░░░░ ░░░░▀█▄▀▄▀██████░▀█▄▀▄▀████▀          #\n
#    ░░░ ░░░░░░░▀█▄█▄███▀░░░▀██▄█▄█▀            #\n
#                                               #\n
#                         ☺                     #\n
#                        /|\\                    #\n
#                        / \\                    #\n
#===============================================#" \

"#==================VELHA FORCA==================#\n
#             (>ºº)v VOCE GANHO <(ºº)V          #\n
#                   PONTOS:$pontos${c:$((21+${#pontos}))}#\n
#    ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄          #\n
#    ░░░░ ░░░░▀█▄▀▄▀██████░▀█▄▀▄▀████▀          #\n
#    ░░░ ░░░░░░░▀█▄█▄███▀░░░▀██▄█▄█▀            #\n
#                        \\☺/                    #\n
#                         |                     #\n
#                        / \\                    #\n
#                                               #\n
#===============================================#" )

mapfile db < db.csv
while :${db[${vez:=$((RANDOM%${#db[@]}))}]} 2>-;do vez=$((RANDOMAND%${#db[@]}));done
db[$vez]=${db[vez]// /_}
atual=( ${db[vez]//,/ } )
termo=${atual[0]//[[:alnum:]]/-}
unset db[$vez]
sessao=1
cp_termo=($(seq 0 ${#termo}))
pontos=0
digitado=''
ch=1
roda=true

c='                                               '
function tela {
clear
echo "

#SESSAO:$sessao${c:$((9+${#sessao})):8}PONTOS:$pontos${c:$((23+${#pontos}))}#
#TERMO:${termo}${c:$((6+${#termo}))}#
#${art[0]}PISTAS:	                #
#${art[1]}${p1}${c:$((16+${#p1}))}#
#${art[2]}${p2}${c:$((16+${#p2}))}#
#${art[3]}${p3}${c:$((16+${#p3}))}#
#${art[4]}${p4}${c:$((16+${#p4}))}#
#${art[5]}                               #
#                                               #
#ERROS:                                         #
#$e${c:$((${#e}))}#
#===============================================#"
}
function fim {
	roda=false
	clear
	echo $1
}
function ganho {
	roda=false
	clear
	while read -n 1 -t 0.5 -p "continuar? (s/n)" fim; do
		 echo -e ${telaGanho[$b]}
		 sleep 0.5
		 clear
		 ((a+=1;b=a%${#telaGanho}))
	 done
	[ ${f,,}=='y' ]&& roda=true || exit 0
}
#tela
while $roda; do	
	declare -n art=art$ch
	declare p$ch="${atual[$ch]//_/ }"
	tela
	read -n1 -p "digite uma letra: " t
	if :${e//[^$t]} 2>&-;then
		if :${atual[0]//*$t*} 2>&-;then
			for a in ${cp_termo[@]};do
				if [[ ${atual[0]:$a:1} = $t && ${termo:$a:1} = '-' ]];then
					termo=${termo:0:$((a))}$t${termo:$((a+1)):${#termo}}
					pontos=$((36-ch))
					[ $termo = ${atual[0]} ] && ganho
#					fim "parabens $pontos"
				fi
			done
		else
			e=$e' '$t
			((ch+=1))
			((ch > 4)) && fim "perdeu!! $pontos"
		fi
	else
		echo "voce ja digitou essa letra"
	fi
done