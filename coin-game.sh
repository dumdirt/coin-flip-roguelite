#!/bin/bash

# ==============================================================
# FIGLET TITLES
# ==============================================================
LOADING_TITLE=$(cat <<- "EOF" 
	██       ██████   █████  ██████  ██ ███    ██  ██████ 
	██      ██    ██ ██   ██ ██   ██ ██ ████   ██ ██      
	██      ██    ██ ███████ ██   ██ ██ ██ ██  ██ ██   ███ 
	██      ██    ██ ██   ██ ██   ██ ██ ██  ██ ██ ██    ██ 
	███████  ██████  ██   ██ ██████  ██ ██   ████  ██████  ██ ██ ██ 
	EOF
)

GAME_TITLE=$(cat <<- "EOF"
	==============================================================
	==============================================================


	██████╗ ██████╗ ██╗███╗   ██╗    ███████╗██╗     ██╗██████╗
	██╔════╝██╔═══██╗██║████╗  ██║    ██╔════╝██║     ██║██╔══██╗
	██║     ██║   ██║██║██╔██╗ ██║    █████╗  ██║     ██║██████╔╝
	██║     ██║   ██║██║██║╚██╗██║    ██╔══╝  ██║     ██║██╔═══╝
	╚██████╗╚██████╔╝██║██║ ╚████║    ██║     ███████╗██║██║
	╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝    ╚═╝     ╚══════╝╚═╝╚═╝
	A Game Where You Must Guess Between Heads or Tails

	==============================================================
	=============================================================
	EOF
)

loading_screen() {
	clear
	
	echo -e "\e[1;31m"
	echo "$LOADING_TITLE"
	echo -e "\e[0m"
	
	sleep 0.2
	clear
}

new_game() {
	echo -e "\e[1;31mSelect a Game Mode\e[0m\n"
	echo -e "\e[1;31m[1]\e[0m Standard"
	echo -e "      In standard mode, you play with the objective of a reaching\n      a gold balance of 10,000 coins. You begin with 100 coins and\n      can bet any amount of your current balance on each round."
	echo -e "\e[1;31m[2]\e[0m Infinite"
	echo -e "      In infinite mode, there is no defined objective besides simply\n      achieving the highest balance possible. You begin with 100 coins\n      and can bet any amount of your current balance on each round."
	echo -e "\e[1;31m[3]\e[0m Return to Main Menu"
	choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				loading_screen
				;;
			2)
				loading_screen
				;;
			3)
				loading_screen
				main_menu
				;;
			*)
				echo -e "\e[1;31mEnter a valid numerical input.\e[0m"
				;;
		esac
	done	
}

game_info() {
	echo -e "\e[1;31m"
	cat <<- "EOF"
		==============================================================
		==============================================================

	EOF
	echo -e "\e[0m"

	echo -e "\e[1;31mHow to Play\e[0m"
	cat <<- "EOF"
	1. Select a game mode.
	2. Place your bet.
	3. Predict whether the coin will land on heads or tails.
	4. A correct bet will earn your wager multiplied by your multiplier.
	5. An incorrect bet will lose your wager.
	EOF

	echo -e "\n\e[1;31mShop System\e[0m"
	cat <<- "EOF"
	Every 5 rounds, the shop will reset, offering three items for purchase.
	Each item will have a unique effect that can be used to your advantage.
	Items can be purchased with your current gold balance.
	EOF

	echo -e "\n\e[1;31mSpecial Events\e[0m"
	cat <<- "EOF"
	Every 5 rounds, a special event will occur that can either help or hinder your progress.
	Events can range from a simple balance increase or decrease to a multiplier change or streak reset.
	EOF

	echo -e "\e[1;31m"
	cat <<- "EOF"

		==============================================================
		==============================================================
	EOF
	echo -e "\e[0m"

	echo -e "\n\e[1;31m[1]\e[0m Return to Main Menu"

	choice=""
	while [[ "$choice" -ne 1 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				loading_screen
				main_menu
				;;
			*)
				echo -e "\e[1;31mEnter a valid numerical input.\e[0m"
				;;
		esac
	done
}

credits() {
	echo -e "\e[1;31mCredits\e[0m"
	echo "This game was created by dirtblock, also known as dumdirt."

	echo -e "\n\e[1;31m[1]\e[0m Return to Main Menu"

	choice=""
	while [[ "$choice" -ne 1 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				loading_screen
				main_menu
				;;
			*)
				echo -e "\e[1;31mEnter a valid numerical input.\e[0m"
				;;
		esac
	done
}

exit_game() {
	echo -e "\e[1;31mExiting game...\e[0m"
	exit
}

main_menu() {
	echo -e "\e[1;31m"
	echo "$GAME_TITLE"
	echo -e "\e[0m"

	echo -e "\e[1;31m[1]\e[0m New Game"
	echo -e "\e[1;31m[2]\e[0m How to Play"
	echo -e "\e[1;31m[3]\e[0m Credits"
	echo -e "\e[1;31m[4]\e[0m Exit Game"

	choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
		do
			read -p " >  " choice
			case "$choice" in 
				1)
					loading_screen
					new_game
					;;
				2)
					loading_screen
					game_info
					;;
				3)
					loading_screen
					credits
					;;
				4)
					exit_game
					;;
				*)
					echo -e "\e[1;31mEnter a valid numerical input.\e[0m"
					;;
			esac
		done
}

clear

main_menu