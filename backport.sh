#!/bin/sh
set -e

#text colors
cprintf() {
	local code="\033["
	case "$1" in
		black ) color="${code}0;30m" ;;
		red   ) color="${code}1;31m" ;;
		green ) color="${code}1;32m" ;;
		yellow) color="${code}1;33m" ;;
		blue  ) color="${code}1;34m" ;;
		purple) color="${code}1;35m" ;;
		cyan  ) color="${code}1;36m" ;;
		gray  ) color="${code}0;37m" ;;
		*) local text="$1"
	esac
	[ -z "$text" ] && local text="$color$2${code}0m"
	printf "$text"
}

#print logo if the logo script exists
clear
cprintf blue "############################### Doki Doki Literature Club Plus Backport ################################\n# "
cprintf green "By: swindlesmccoop, see https://git.cbps.xyz/swindlesmccoop/DDLC-Plus-Backport/ for more information "
cprintf blue "#\n########################################################################################################\n"
#[ -f logo.sh ] && printf "\n" && sh logo.sh
printf "\n"

#choice function
choice () {
	cprintf cyan "$1"
	QUERY=$2
	read QUERY
	if [ "$QUERY" = "y" ]; then
		true
	else
		cprintf red "$3\n\n"
		command "$4"
	fi
}

#dependency install
windeps () {
	cprintf gray "Installing dependencies...\n"
	pacman -S --needed --noconfirm < dependencies.txt
}

archdeps () {
	cprintf gray "Installing dependencies...\n"
	sudo pacman -S --needed --noconfirm < dependencies.txt
}

debdeps () {
	cprintf gray "Installing dependencies...\n"
	< dependencies.txt xargs sudo apt-get install -y
}

#actual script
choice "Do you have the DDLC Plus assets? (y/n): " Q_ASSETS "In order to comply with Team Salvato's IP guidelines and the rules of the DDLC Modding Subr*ddit, you need to have the assets on hand." exit
choice "Are you running this script on Linux? (y/n): " Q_OS "WARNING: This script may technically function on Windows, however behavior is experimental." windeps

case "$1" in
	arch  ) archdeps ;;
	debian) debdeps ;;
	skip  ) cprintf red "Please read and install programs from dependencies.txt! When you are done, press the Enter key to continue." && read ENT
esac

read -r -p "Please enter the path to your DDLC Plus install: " DDLCPLUS
read -r -p "Please enter the path to your original DDLC install: " OGDDLC
