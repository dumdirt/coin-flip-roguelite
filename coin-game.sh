#!/bin/bash

# ==============================================================
# FIGLET TITLES
# ==============================================================

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

# ==============================================================
# GAME VARIABLES
# ==============================================================
player_name=""
gold_balance=100
streak=0
multiplier=100
round=1
current_event="..."
dialogue="..."
inventory=()

# ==============================================================
# GAME COLOR VARIABLES
# ==============================================================
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
PURPLE=$'\e[1;35m'
CYAN=$'\e[1;36m'
WHITE=$'\e[1;37m'
RESET=$'\e[0m'

# =============================================================
# DECIMAL DISPLAY SYSTEM
# =============================================================
display_multiplier() {
	printf "x%d.%d" $((multiplier / 100)) $((multiplier % 100))
}

# =============================================================
# LOADING SCREEN
# =============================================================
loading_screen() {
	clear
	echo -e "${RED}LOADING...${RESET}"
	sleep 1.5
	clear
}

# =============================================================
# GET PLAYER NAME
# =============================================================
get_player_name() {
	clear
	echo -e "${RED}Enter your Player Name${RESET}"
	read -p " >  " player_name
}

# =============================================================
# MAIN MENU UI
# =============================================================
main_menu() {
	clear

	echo "${RED}$GAME_TITLE${RESET}"
	
	echo -e "\n${RED}[1]${RESET} New Game"
	echo -e "${RED}[2]${RESET} How to Play"
	echo -e "${RED}[3]${RESET} Credits"
	echo -e "${RED}[4]${RESET} Exit Game"

	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
		do
			read -p " >  " choice
			case "$choice" in 
				1)
					new_game
					;;
				2)
					game_info
					;;
				3)
					credits
					;;
				4)
					exit_game
					;;
				*)
					echo -e "${RED}Enter a valid numerical input.${RESET}"
					;;
			esac
		done
}

# =============================================================
# MAIN MENU OPTIONS
# =============================================================
new_game() {
	clear

	echo -e "${RED}"
	cat <<- "EOF"
		==============================================================
		==============================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}Select a Game Mode${RESET}"
	echo "Choose between Standard mode or Infinite mode."

	echo -e "${RED}"
	cat <<- "EOF"
		==============================================================
		==============================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}[1]${RESET} Standard"
	echo "      In standard mode, you play with the objective of reaching"
	echo "      a gold balance of 10,000 coins. You begin with 100 coins and"
	echo -e "      can bet any amount of your current balance on each round.\n"

	echo -e "${RED}[2]${RESET} Infinite"
	echo "      In infinite mode, there is no defined objective besides simply"
	echo "      achieving the highest balance possible. You begin with 100 coins"
	echo -e "      and can bet any amount of your current balance on each round.\n"

	echo -e "${RED}[3]${RESET} Return to Main Menu"

	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				get_player_name
				loading_screen
				standard_mode
				;;
			2)
				get_player_name
				loading_screen
				infinite_mode
				;;
			3)
				main_menu
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done	
}

game_info() {
	clear

	echo -e "${RED}"
	cat <<- "EOF"
		==============================================================
		==============================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}How to Play${RESET}"
	echo "1. Select a game mode."
	echo "2. Place your bet."
	echo "3. Predict whether the coin will land on heads or tails."
	echo "4. A correct bet will earn your wager multiplied by your"
	echo "   multiplier."
	echo "5. An incorrect bet will lose your wager."

	echo -e "\n${RED}Shop System${RESET}"
	echo "Every 5 rounds, the shop will reset, offering three items for"
	echo "purchase."
	echo "Each item will have a unique effect that can be used to your"
	echo " advantage."
	echo "Items can be purchased with your current gold balance."

	echo -e "\n${RED}Special Events${RESET}"
	echo "Every 5 rounds, a special event will occur that can either help"
	echo "or hinder your progress."
	echo "Events can range from a simple balance increase or decrease to"
	echo "a multiplier change or streak reset."

	echo -e "${RED}"
	cat <<- "EOF"
		==============================================================
		==============================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}[1]${RESET} Return to Main Menu"

	local choice=""
	while [[ "$choice" -ne 1 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				main_menu
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

credits() {
	clear

	echo -e "${RED}"
	cat <<- "EOF"
		==============================================================
		==============================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}Credits${RESET}"
	echo "This game was created by dirtblock, also known as dumdirt."

	echo -e "${RED}"
	cat <<- "EOF"
		==============================================================
		==============================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}[1]${RESET} Return to Main Menu"

	local choice=""
	while [[ "$choice" -ne 1 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				main_menu
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

exit_game() {
	clear
	echo -e "${RED}EXITING GAME...${RESET}"
	sleep 1.5
	clear
	exit
}

# =============================================================
# GAME LOGIC
# =============================================================
place_bet() {
	clear
	
	cat <<- EOF
	${RED}=============================================================${RESET}
	${RED}Betting Rules ${RESET}
	~~~ WARNING: Betting will end the current round ~~~
	1. All bets must be at least 10 coins and an integer number.
	2. All winnings will be rounded down to the nearest whole number.
	
	You currently have ${YELLOW}$gold_balance${RESET} coins.
	${RED}=============================================================${RESET}
	EOF

	echo -e "${RED}Enter your bet amount:${RESET}"
	local bet_amount=""
	while [[ "$bet_amount" -gt "$gold_balance" || "$bet_amount" -lt 10 || ! "$bet_amount" =~ ^[0-9]+$ ]]
	do
		read -p " >  " bet_amount
	done

	echo -e "${RED}Choose 'HEADS' or 'TAILS':${RESET}"
	local player_guess=""
	while [[ "$player_guess" != "HEADS" && "$player_guess" != "TAILS" ]]
	do
		read -p " >  " player_guess
	done

	echo -e "\n${RED}[1]${RESET} Confirm Bet"
	echo -e "${RED}[2]${RESET} Cancel Bet"
	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				flip_coin "$player_guess" "$bet_amount"
				standard_mode
				;;
			2)
				standard_mode
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

flip_coin() {
	clear

	echo -e "${RED}Flipping Coin...${RESET}"
	sleep 1.5

	local coin_result=$((RANDOM % 2))
	if [[ "$coin_result" -eq 0 ]]
	then
		coin_result="HEADS"
	else
		coin_result="TAILS"
	fi

	if [[ "$player_guess" == "$coin_result" ]]
	then
		local winnings=$((bet_amount * multiplier / 100))
		gold_balance=$((gold_balance + winnings))
		dialogue="You guessed correctly! You ${GREEN}won${RESET} ${YELLOW}$winnings${RESET} coins."
		streak=$((streak + 1))
	else
		gold_balance=$((gold_balance - bet_amount))
		dialogue="You guessed incorrectly. You ${RED}lost${RESET} ${YELLOW}$bet_amount${RESET} coins."
		streak=0
	fi

	round=$((round + 1))
}

# =============================================================
# GAME UI
# =============================================================
game_banner() {
	echo -e "${RED}"
	cat <<- "EOF"
	=============================================================
	            ___ ___ ___ _  _   ___ _    ___ ___ 
	           / __/ _ \_ _| \| | | __| |  |_ _| _ \
	          | (_| (_) | || .` | | _|| |__ | ||  _/
	           \___\___/___|_|\_| |_| |____|___|_|
	=============================================================
	EOF
	echo -e "${RESET}"
}

player_stats() {
	cat <<- EOF
	👤 Player Name: ${WHITE}$player_name${RESET}

	🪙  Gold Balance: ${YELLOW}$gold_balance${RESET}              ❌ Multiplier: ${GREEN}$(display_multiplier)${RESET}
	⏰ Round Number: ${BLUE}$round${RESET}                   🔥 Streak: ${CYAN}$streak${RESET}
	🎲 Current Event: ${PURPLE}$current_event${RESET}
	${RED}=============================================================${RESET}
	EOF
}

dialogue_box() {
	cat <<- EOF

	💬 ${dialogue}

	${RED}=============================================================${RESET}

	EOF
}

player_options() {
	echo -e "${RED}[1]${RESET} Place Bet"
	echo -e "${RED}[2]${RESET} View Inventory"
	echo -e "${RED}[3]${RESET} View Shop"
	echo -e "${RED}[4]${RESET} Exit to Main Menu"

	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				place_bet
				;;
			2)
				:
				;;
			3)
				:
				;;
			4)
				main_menu
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

# =============================================================
# GAME MODES
# =============================================================
standard_mode() {
	clear

	while [[ "$gold_balance" -lt 10000 && "$gold_balance" -ge 10 ]]
	do
		game_banner
		player_stats
		dialogue_box
		player_options
	done
}

infinite_mode() {
	clear
}

# Start game by displaying the main menu
main_menu