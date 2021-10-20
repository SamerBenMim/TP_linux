#!/bin/bash
choice=-1
while [ $choice != 0 ]
do
echo "

****************************************************
Bonjour choisissez une option :
1 - Lister les utilisateurs
2 - Modifier un utilisateur
3 - Ajouter un utilisateur
4 - Supprimer un utilisateur 
0 - Exit"
read choice
case "$choice" in
0) echo "BYE";;
1)cat /etc/passwd | awk -F: '{printf("%d\t%s\n",$3,$1);}';;
2) echo donnez l id
read id 
user=$(cat /etc/passwd | awk -F: '{printf("%d:%s\n",$3,$1);}' | grep $id | awk -F: '{printf("%s\n",$2);}')
choice2=-1

while [ $choice2 != 0 ]
do
	echo "
*****************************************************
1-modifier nom utilisateur
2-modifier password
3-modifier shell
4-modifier home dir
5-bloquer utilisateur
6-débloquer utilisateur
7-changer intial group
8-changer uid
9-lister infos
0-exit
"

read choice2
case "$choice2" in
1)echo "saisir le nouveau nom"
	read newname
	sudo usermod $user -l $newname
	user=$newname;;

2)passwd $user;;
3)nl -s')' bash_list
echo "choisir un interpréteur de commandes"
read id
shell=$(nl -s')' bash_list | grep -w 4 | sed 's/^ *//g' | cut -d')' -f2)
echo $shell
sudo usermod $user -s $shell;;
4)echo "saisir le nouveau home directory"
	read directory
	 sudo usermod $user -d $directory;;
5)passwd -l $user;;
6)passwd -u $user;;
7)echo " donner le groupe"
	read group
	 sudo usermod $user -g $group;;  
8)echo " donner le nouveau uid"
	read uid
	sudo usermod $user -u $uid
	id=$uid;;
9)grep -w ^$user /etc/passwd;;
0)echo "Exited $user's settings";;
*)echo "wrong choice";;
esac
done
  ;;
3) echo donner le nom du user 
read nom
sudo useradd $nom;;
4) echo "supprimer utilisateur"
echo donnez l id
read id
user=$(cat /etc/passwd | awk -F: '{printf("%d:%s\n",$3,$1);}' | grep $id | awk -F: '{printf("%s\n",$2);}')
sudo userdel $user;;
*) echo "invalid choice";;

esac
done