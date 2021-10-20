#!/bin/bash
choice=-1
while [ $choice != 0 ]
do 
echo "

********************************************************
Bonjour choisissez une option :
1 - Lister les modules
2 - Afficher les informations d'un module
3 - Décharger un module de la memoire
4 - Inserer un module dans le kernel
5 - tester l'existance d'un module
6 - Afficher les informations du systeme d'exploitation
0 - Exit"
read choice

case "$choice" in 
1) lsmod | nl;; 
2) echo 'donner le numero de module pour afficher ses information'
read num ;
lsmod | nl |sed 's/^ *//g'|grep ^$num| head -1 |cut  -f2|cut -d" " -f1|xargs modinfo   ;;
3) echo 'donner le numero de module a déchargé'
read num ;
lsmod | nl |sed 's/^ *//g'|grep ^$num| head -1  | cut  -f2|cut -d" " -f1|tee -a remouved.txt|xargs sudo rmmod  && echo "le module a été bien déchargé de la mémoire" ;;
4) echo "voici la liste des module déchargés :
"
nl remouved.txt  
echo "
choisir le module a recharger"
read num
nl remouved.txt|sed 's/^ *//g'|grep ^$num|cut -f2|xargs sudo modprobe && echo "le module a ete ajoute avec succes" 
 sed $num'd' remouved.txt -i

 ;;
5) echo "Donnez le nom d'un module"
read module 
lsmod | grep $module --color;;
6) uname -a;;

*) echo "invalid choice";;

esac
done
