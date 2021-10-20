#!/bin/bash
choice=-1
while [ $choice != 0 ]
do
echo -e "0)exit \n1)lister les fichiers rcd\n2)afficher le contenu d'un fichier\n3)contenu d'un dossier\n4)modifier runlevel\n5)donner le runlevel courant \n6)donner runlevel courant et precedent\n7)donner runlevel par defaut\n8)choisir runlevel par defaut\n9)shutdown system\n10)reboot system"
read choice
case "$choice" in
1) ls /etc | grep '^rc*';;
2)echo " nom du fichier "
read fichier
cat /etc/$fichier;;
3)echo " nom du fichier "
read fichier
ls /etc/$fichier;;
4)echo " choisier run level"
read i
init $i;;
5)who -r;;
6)runlevel;;
7)systemctl get-default;;
8)echo "Choisir numero niveau par defaut"
read level
systemctl set-default $level;;
9)init 0
shutdown -h now
halt
poweroff;;
10)init6
shutdown -r now
reboot;;

0)echo "BYE";;
*) echo "invalid choice";;
esac
done

