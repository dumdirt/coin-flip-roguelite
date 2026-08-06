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
round=0
dialogue_bet="..."
dialogue_multiplier="..."
dialogue_event="..."
inventory=()
event_list=("Tax Collector" "Inheritance" "Multiplier Boost" "Unlucky Day" "Mysterious Gift" "Streak Reset" "Lucky Day" "Wheel of Fortune" "Bankruptcy" "Slot Machine")
current_event="..."
shop_catalogue=("Bet Insurance" "4-Leafed Clover" "Event Insurance" "Magic Dice" "Double Down Voucher" "Lucky Coin" "Shop Coupon" "Cursed Token")
current_shop=()
active_item="..."
# Bet Insurance: Lose 50% of the next bet
# 4-Leafed Clover: Guarantees a win on the next bet
# Event Inusrance: Protects against one instance of event coin loss the next round
# Magic Dice: Rerolls the shop's current items
# Double Down Voucher: Gain double or lose double your next bet
# Lucky Coin: Refund your next bet if it's a loss
# Shop Coupon: Your next shop purchase costs 50% less
# Cursed Token: Instantly double your multiplier, but lose 25% of your gold balance

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
# GAME MODES
# =============================================================
standard_mode() {
	clear

	while [[ "$gold_balance" -lt 10000 && "$gold_balance" -ge 10 ]]
	do
		clear
		trigger_event
		game_banner
		player_stats
		dialogue_box
		player_options
	done
}

infinite_mode() {
	clear
}

# =============================================================
# GAME LOGIC
# =============================================================
place_bet() {
	clear
	
	cat <<- EOF
	${RED}=============================================================${RESET}
	${RED}=============================================================${RESET}

	${RED}Betting Rules${RESET}
	~~~ WARNING: Betting will end the current round. ~~~
	1. All bets must be at least 10 coins and an integer number.
	2. All winnings will be rounded down to the nearest whole number.
	
	You currently have ${YELLOW}$gold_balance${RESET} coins.

	${RED}=============================================================${RESET}
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
	echo -e "${RED}[2]${RESET} Return to Game"
	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				flip_coin "$player_guess" "$bet_amount"
				return
				;;
			2)
				return
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

flip_coin() {
	clear

	echo -e "${RED}FLIPPING COIN...${RESET}"
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
		dialogue_bet="You guessed correctly! You won ${YELLOW}$winnings${RESET} coins."
		streak=$((streak + 1))
		if [[ "$streak" -ge 5 ]]
		then
			if [[ $((streak % 5)) -eq 0 ]]
			then
				multiplier=$((multiplier + (streak / 5) * 50))
				dialogue_multiplier="Streak achieved! Multiplier increased to ${GREEN}$(display_multiplier)${RESET}."
			elif [[ $((streak % 5)) -ne 0 ]]
			then
				dialogue_multiplier="..."
			fi
		elif [[ "$streak" -lt 5 && "$multiplier" -gt 100 ]]
		then
			multiplier=100
		fi
	else
		gold_balance=$((gold_balance - bet_amount))
		dialogue_bet="You guessed incorrectly. You lost ${YELLOW}$bet_amount${RESET} coins."
		streak=0
	fi

	round=$((round + 1))
}

trigger_event() {
	if [[ $((round % 5)) -eq 0 && "$round" -ne 0 ]]
	then
		local event_index=$((RANDOM % ${#event_list[@]}))
		current_event="${event_list[$event_index]}"
		case "$current_event" in

			# Tax Collector: Lose 10% of your current gold balance.
			"Tax Collector")
				local tax_amount=$((gold_balance / 10))
				gold_balance=$((gold_balance - tax_amount))
				dialogue_event="The Tax Collector has approaches... He takes ${YELLOW}$tax_amount${RESET} coins from you."
				;;
			
			# Inheritance: Gain 100 coins.
			"Inheritance")
				gold_balance=$((gold_balance + 100))
				dialogue_event="Your late relative has passed away. She left an inheritance of ${YELLOW}100${RESET} coins to you."
				;;
			
			# Multiplier Boost: Increase streak by 5 and multiplier by 0.5x.
			"Multiplier Boost")
				streak=$((streak + 5))
				multiplier=$((multiplier + 50))
				dialogue_event="You won a few dealings... Your streak has increased by ${CYAN}5${RESET} and multiplier by ${GREEN}0.5x${RESET}."
				;;
			
			# Unlucky Day: Lose 50 coins.
			"Unlucky Day")
				gold_balance=$((gold_balance - 50))
				dialogue_event="You tried to deal with a shady dealer... You lost ${YELLOW}50${RESET} coins."
				;;
			
			# Mysterious Gift: Gain a mystery item if your inventory is not full.
			"Mysterious Gift")
				if [[ "${#inventory[@]}" -lt 3 ]]
				then
					inventory+="Mystery Item"
					dialogue_event="A man in a dark cloak approaches you and hands you a mysterious gift: ${PURPLE}Mystery Item${RESET}."
				else
					dialogue_event="A man in a dark cloak approaches you and offers you a mysterious gift... You decline, as your inventory is full."
				fi
				;;
			
			# Streak Reset: Streak is reset to 0.
			"Streak Reset")
				streak=0
				dialogue_event="You had a bad day gambling... Your streak has been reset to ${CYAN}0${RESET}."
				;;
			
			# Lucky Day: Gain 50 coins.
			"Lucky Day")
				gold_balance=$((gold_balance + 50))
				dialogue_event="You found a lost wallet on the street. You gained ${YELLOW}50${RESET} coins."
				;;
			
			# Wheel of Fortune: Randomly gain or lose 50% of your current gold balance.
			"Wheel of Fortune")
				local fortune_outcome=$((RANDOM % 2))
				if [[ "$fortune_outcome" -eq 0 ]]
				then
					local loss_amount=$((gold_balance / 2))
					gold_balance=$((gold_balance - loss_amount))
					dialogue_event="The Wheel of Fortune was unlucky! You lost ${YELLOW}$loss_amount${RESET} coins."
				else
					local gain_amount=$((gold_balance / 2))
					gold_balance=$((gold_balance + gain_amount))
					dialogue_event="The Wheel of Fortune was lucky! You gained ${YELLOW}$gain_amount${RESET} coins."
				fi
				;;
			
			# Bankruptcy: Lose 50% of your current gold balance.
			"Bankruptcy")
				local loss_amount=$((gold_balance / 2))
				gold_balance=$((gold_balance - loss_amount))
				dialogue_event="You went bankrupt! You lost ${YELLOW}$loss_amount${RESET} coins."
				;;
			
			# Slot Machine: Randomly gain between 10 and 50 coins.
			"Slot Machine")
				local slot_gain=$((RANDOM % 41 + 10))
				gold_balance=$((gold_balance + slot_gain))
				dialogue_event="You played the slot machine and won ${YELLOW}$slot_gain${RESET} coins."
				;;
		esac
	else
		current_event="..."
		dialogue_event="..."
	fi
}

trigger_shop() {
	clear

	if [[ $((round % 5)) -eq 0 || "$round" -eq 0 ]]
	then
		current_shop=()

		for (( i=1; i<=3; i++))
		do
			local shop_index=$((RANDOM % ${#shop_catalogue[@]}))
			current_shop+=("${shop_catalogue[shop_index]}")
		done
	fi

	cat <<- EOF
	${RED}=============================================================${RESET}
	${RED}=============================================================${RESET}

	${RED}The Shop${RESET}
	~~~ NOTICE: The inventory is limited to three items. ~~~
	
	EOF

	for i in "${!current_shop[@]}"
	do
		printf "Item: ${PURPLE}%s${RESET}\n\n" "${current_shop[$i]}"
	done

	cat <<- EOF
	You currently have ${YELLOW}$gold_balance${RESET} coins.

	${RED}=============================================================${RESET}
	${RED}=============================================================${RESET}

	EOF

	echo -e "${RED}[1]${RESET} Buy ${current_shop[0]}"
	echo -e "${RED}[2]${RESET} Buy ${current_shop[1]}"
	echo -e "${RED}[3]${RESET} Buy ${current_shop[2]}"
	echo -e "${RED}[4]${RESET} Return to Game"

	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				:
				;;
			2)
				:
				;;
			3)
				:
				;;
			4)
				return
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

# =============================================================
# GAME UI
# =============================================================
game_banner() {
	echo -e "${RED}"
	cat <<- "EOF"
	=============================================================
	=============================================================
	            ___ ___ ___ _  _   ___ _    ___ ___ 
	           / __/ _ \_ _| \| | | __| |  |_ _| _ \
	          | (_| (_) | || .` | | _|| |__ | ||  _/
	           \___\___/___|_|\_| |_| |____|___|_|
	=============================================================
	=============================================================
	EOF
	echo -e "${RESET}"
}

player_stats() {
	echo -e "👤 Player Name: ${WHITE}$player_name${RESET}\n"
	printf "🪙  Gold Balance: ${YELLOW}%-10s${RESET} ❌ Multiplier: ${GREEN}%-10s${RESET}" "$gold_balance" "$(display_multiplier)"
	printf "\n⏰ Round Number: ${BLUE}%-10s${RESET} 🔥 Streak: ${CYAN}%-10s${RESET}" "$((round + 1))" "$streak"
	printf "\n🎲 Current Event: ${PURPLE}%-9s${RESET} ♟️  Active Item: ${PURPLE}%-10s${RESET}" "$current_event" "$active_item"
	echo -e "\n${RED}=============================================================${RESET}"
}

dialogue_box() {
	cat <<- EOF

	💬 ${dialogue_bet}
	💬 ${dialogue_multiplier}
	💬 ${dialogue_event}

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
				trigger_shop
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

# Start game by displaying the main menu
main_menu