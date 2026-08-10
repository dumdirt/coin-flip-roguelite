#!/bin/bash

# ==============================================================
# FIGLET TITLES
# ==============================================================
GAME_TITLE=$(cat <<- "EOF"
	===========================================================================
	===========================================================================


	         ██████╗ ██████╗ ██╗███╗   ██╗    ███████╗██╗     ██╗██████╗ 
	        ██╔════╝██╔═══██╗██║████╗  ██║    ██╔════╝██║     ██║██╔══██╗
	        ██║     ██║   ██║██║██╔██╗ ██║    █████╗  ██║     ██║██████╔╝
	        ██║     ██║   ██║██║██║╚██╗██║    ██╔══╝  ██║     ██║██╔═══╝ 
	        ╚██████╗╚██████╔╝██║██║ ╚████║    ██║     ███████╗██║██║     
	         ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝    ╚═╝     ╚══════╝╚═╝╚═╝     
	                A Simple Coin Flip-based Roguelite Game


	===========================================================================
	===========================================================================

	EOF
)

GAME_OVER_TITLE=$(cat <<- "EOF"
	===========================================================================
	===========================================================================


	 ██████╗  █████╗ ███╗   ███╗███████╗     ██████╗ ██╗   ██╗███████╗██████╗ 
	██╔════╝ ██╔══██╗████╗ ████║██╔════╝    ██╔═══██╗██║   ██║██╔════╝██╔══██╗
	██║  ███╗███████║██╔████╔██║█████╗      ██║   ██║██║   ██║█████╗  ██████╔╝
	██║   ██║██╔══██║██║╚██╔╝██║██╔══╝      ██║   ██║╚██╗ ██╔╝██╔══╝  ██╔══██╗
	╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗    ╚██████╔╝ ╚████╔╝ ███████╗██║  ██║
	 ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝     ╚═════╝   ╚═══╝  ╚══════╝╚═╝  ╚═╝


	===========================================================================
	===========================================================================

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
current_round=-1
dialogue_bet="..."
dialogue_multiplier="..."
dialogue_event="..."
inventory=()
event_list=("Tax Collector" "Inheritance" "Multiplier Boost" "Unlucky Day" "Mysterious Gift" "Streak Reset" "Lucky Day" "Wheel of Fortune" "Bankruptcy" "Slot Machine")
current_event="..."
shop_catalogue=("Bet Insurance" "4-Leafed Clover" "Event Insurance" "Magic Dice" "Double Down Voucher" "Lucky Coin" "Shop Coupon" "Cursed Token")
shop_catalogue_costs=(500 1250 1000 250 1000 750 500 1500)
current_shop=()
current_shop_costs=()
shop_item1_purchased=0
shop_item2_purchased=0
shop_item3_purchased=0
active_item="..."
multiplier_cap=0
total_items=0
total_events=0
max_multiplier=0
max_streak=0

# ==============================================================
# ANSI ESCAPE CODES VARIABLES
# ==============================================================
RED=$'\e[1;31m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
BLUE=$'\e[1;34m'
PURPLE=$'\e[1;35m'
CYAN=$'\e[1;36m'
WHITE=$'\e[1;37m'
RESET=$'\e[0m'
STRIKETHROUGH=$'\e[9m'

# =============================================================
# DECIMAL DISPLAY SYSTEM
# =============================================================
display_multiplier() {
	printf "x%d.%d" $((multiplier / 100)) $((multiplier % 100))
}

display_max_multiplier() {
	printf "x%d.%d" $((max_multiplier / 100)) $((max_multiplier % 100))
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

	# Reset the main game variables
	player_name=""
	gold_balance=100
	streak=0
	multiplier=100
	round=0
	current_round=-1
	dialogue_bet="..."
	dialogue_multiplier="..."
	dialogue_event="..."
	inventory=()
	event_list=("Tax Collector" "Inheritance" "Multiplier Boost" "Unlucky Day" "Mysterious Gift" "Streak Reset" "Lucky Day" "Wheel of Fortune" "Bankruptcy" "Slot Machine")
	current_event="..."
	shop_catalogue=("Bet Insurance" "4-Leafed Clover" "Event Insurance" "Magic Dice" "Double Down Voucher" "Lucky Coin" "Shop Coupon" "Cursed Token")
	shop_catalogue_costs=(500 1250 1000 250 1000 750 500 1500)
	current_shop=()
	current_shop_costs=()
	shop_item1_purchased=0
	shop_item2_purchased=0
	shop_item3_purchased=0
	active_item="..."
	multiplier_cap=0
	total_items=0
	total_events=0
	max_multiplier=0
	max_streak=0

	echo "${RED}$GAME_TITLE${RESET}"
	
	# Display user options
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
		===========================================================================
		===========================================================================
	EOF
	echo -e "${RESET}"

	echo -e "${RED}Select a Game Mode${RESET}"
	echo "Choose between Standard mode or Infinite mode."

	echo -e "${RED}"
	cat <<- "EOF"
		===========================================================================
		===========================================================================
	EOF
	echo -e "${RESET}"


	# Display user options

	# Standard mode information
	echo -e "${RED}[1]${RESET} Standard Mode"
	echo "      In standard mode, you play with the objective of reaching"
	echo "      a gold balance of 10,000 coins. You begin with 100 coins and"
	echo -e "      can bet any amount of your current balance on each round.\n"

	# Infinite mode information
	echo -e "${RED}[2]${RESET} Infinite Mode"
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
		===========================================================================
		===========================================================================
	EOF
	echo -e "${RESET}"

	# Core gameplay information
	echo -e "${RED}How to Play${RESET}"
	echo "1. Select a game mode."
	echo "2. Place your bet."
	echo "3. Predict whether the coin will land on heads or tails."
	echo "4. A correct bet will earn your wager multiplied by your multiplier."
	echo "5. An incorrect bet will lose your wager."

	# Shop system information
	echo -e "\n${RED}Shop System${RESET}"
	echo "Every 5 rounds, the shop will reset, offering three items for purchase."
	echo "Each item will have a unique effect that can be used to your advantage."
	echo "Items can be purchased with your current gold balance."

	# Inventory system information
	echo -e "\n${RED}Inventory System${RESET}"
	echo "A maximum of 3 items may be stored in your inventory at once."
	echo "Using an item will permanently delete it from your inventory."
	echo "Items must be active for their effects to apply."

	# Event information
	echo -e "\n${RED}Special Events${RESET}"
	echo "Every 5 rounds, a special event will occur that can either help or"
	echo "hinder your progress."
	echo "Events can range from a simple balance increase or decrease to a"
	echo "multiplier change or streak reset."

	echo -e "${RED}"
	cat <<- "EOF"
		===========================================================================
		===========================================================================
	EOF
	echo -e "${RESET}"

	# Display user options
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
		===========================================================================
		===========================================================================
	EOF
	echo -e "${RESET}"

	# Credits for game contributors
	echo -e "${RED}Credits${RESET}"
	echo "This game was created by dirtblock, also known as dumdirt."

	echo -e "${RED}"
	cat <<- "EOF"
		===========================================================================
		===========================================================================
	EOF
	echo -e "${RESET}"

	# Display user options
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
	SECONDS=0

	# Check if gold_balance is sufficient to continue the game
	while [[ "$gold_balance" -lt 10000 && "$gold_balance" -ge 10 ]]
	do
		clear
		trigger_event

		if [[ "$gold_balance" -lt 10 ]]
		then
			break
		fi

		reset_shop
		game_banner
		player_stats
		dialogue_box
		player_options
	done

	if [[ "$gold_balance" -ge 10000 ]]
	then
		game_win
	else
		game_over
	fi
}

infinite_mode() {
	clear
	SECONDS=0

	# Check if gold_balance is sufficient to continue the game
	while [[ "$gold_balance" -ge 10 ]]
	do
		clear
		trigger_event

		if [[ "$gold_balance" -lt 10 ]]
		then
			break
		fi

		reset_shop
		game_banner
		player_stats
		dialogue_box
		player_options
	done

	game_over
}

# =============================================================
# GAME LOGIC
# =============================================================
place_bet() {
	clear
	
	cat <<- EOF
	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	${RED}Betting Information${RESET}
	~~~ NOTICE: Betting will end the current round. ~~~
	1. All bets must be at least 10 coins and an integer number.
	2. All winnings will be rounded down to the nearest integer number.
	
	You currently have ${YELLOW}$gold_balance${RESET} coins.

	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	EOF

	# Get bet amount
	echo -e "${RED}Enter your bet amount:${RESET}"
	local bet_amount=""
	while [[ "$bet_amount" -gt "$gold_balance" || "$bet_amount" -lt 10 || ! "$bet_amount" =~ ^[0-9]+$ ]]
	do
		read -p " >  " bet_amount
	done

	# Get user input for coin flip
	echo -e "${RED}Choose 'HEADS' or 'TAILS':${RESET}"
	local player_guess=""
	while [[ "$player_guess" != "HEADS" && "$player_guess" != "TAILS" ]]
	do
		read -p " >  " player_guess
	done

	# Confirm or cancel bet
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
	dialogue_multiplier="..."

	echo -e "${RED}FLIPPING COIN...${RESET}"
	sleep 1.5

	# Get result of coin flip
	local coin_result=$((RANDOM % 2))
	if [[ "$coin_result" -eq 0 ]]
	then
		coin_result="HEADS"
	else
		coin_result="TAILS"
	fi

	# Guarantee win if 4-Leafed Clover is used
	if [[ "$active_item" == "4-Leafed Clover" ]]
	then
		player_guess="$coin_result"
	fi

	# Check if player guess is equal to coin flip result
	if [[ "$player_guess" == "$coin_result" ]]
	then
		
		# Double Down Voucher: Doubles winnings if bet is won
		if [[ "$active_item" == "Double Down Voucher" ]]
		then
			local double_down_winnings=$((bet_amount * 2 * multiplier / 100 ))
			gold_balance=$((gold_balance + double_down_winnings))
			dialogue_bet="You guessed correctly and won ${YELLOW}$double_down_winnings${RESET} coins due to 'Double Down Voucher.'"
			streak=$((streak + 1))
			active_item="..."
		
		# Add winnings to gold balance
		# Increase streak by 1
		else
			local winnings=$((bet_amount * multiplier / 100))
			gold_balance=$((gold_balance + winnings))
			dialogue_bet="You guessed correctly! You won ${YELLOW}$winnings${RESET} coins."
			streak=$((streak + 1))
		fi

		# Check if multiplier is not capped and if streak is a multiple of 5
		# Increase multiplier by 50 (x0.5)
		if [[ "$multiplier_cap" -ne 1 ]]
		then
			if [[ "$streak" -ge 5 ]]
			then
				if [[ $((streak % 5)) -eq 0 ]]
				then
					multiplier=$((multiplier + 50))
					dialogue_multiplier="Streak achieved! Multiplier increased to ${GREEN}$(display_multiplier)${RESET}."
				fi
			fi
		fi

		# Check if max_streak is less than streak
		# Set max_streak equal to streak
		if [[ "$max_streak" -lt "$streak" ]]
		then
			max_streak="$streak"
		fi

		# Check if max_multiplier is less than multiplier
		# Set max_multiplier equal to multiplier
		if [[ "$max_multiplier" -lt "$multiplier" ]]
		then
			max_multiplier="$multiplier"
		fi
	else

		# Bet Insurance: Reduces bet loss by 50%
		if [[ "$active_item" == "Bet Insurance" ]]
		then
			local bet_insurance_loss=$((bet_amount / 2))
			gold_balance=$((gold_balance - bet_insurance_loss))
			dialogue_bet="You guessed incorrectly, but only lost ${YELLOW}$bet_insurance_loss${RESET} coins due to 'Bet Insurance.'"
			streak=0
			multiplier=100
			active_item="..."

		# Lucky Coin: Refunds bet loss
		elif [[ "$active_item" == "Lucky Coin" ]]
		then
			dialogue_bet="You guessed incorrectly, but lost ${YELLOW}0${RESET} coins due to 'Lucky Coin.'"
			streak=0
			multiplier=100
			active_item="..."

		# Double Down Voucher: Doubles the bet loss if bet is lost
		elif [[ "$active_item" == "Double Down Voucher" ]]
		then
			local double_down_loss=$((bet_amount * 2))
			gold_balance=$((gold_balance - double_down_loss))
			dialogue_bet="You guessed incorrectly and lost ${YELLOW}$double_down_loss${RESET} coins due to 'Double Down Voucher.'"
			streak=0
			multiplier=100
			active_item="..."

		# Subtract losses from gold balance
		# Reset streak to 0
		else
			gold_balance=$((gold_balance - bet_amount))
			dialogue_bet="You guessed incorrectly. You lost ${YELLOW}$bet_amount${RESET} coins."
			streak=0
			if [[ "$active_item" != "Cursed Token" ]]
			then
				multiplier=100
			fi
		fi
	fi

	# Increase round by 1
	round=$((round + 1))
}

trigger_event() {

	# Check if round is a multiple of 5 and not equal to 0
	if [[ $((round % 5)) -eq 0 && "$round" -ne 0 ]]
	then
		if [[ "$round" -ne "$current_round" ]]
		then

			# Get index from event_list for current_event
			local event_index=$((RANDOM % ${#event_list[@]}))
			current_event="${event_list[$event_index]}"
			total_events=$((total_events + 1))
			case "$current_event" in

				# Tax Collector: Lose 10% of your current gold balance.
				"Tax Collector")
					if [[ "$active_item" == "Event Insurance" ]]
					then
						dialogue_event="Event Insurance has protected you from the Tax Collector."
					elif [[ "$active_item" != "Event Insurance" ]]
					then
						local tax_amount=$((gold_balance / 10))
						gold_balance=$((gold_balance - tax_amount))
						dialogue_event="The Tax Collector has approaches... He takes ${YELLOW}$tax_amount${RESET} coins from you."
					fi
					;;
				
				# Inheritance: Gain 100 coins.
				"Inheritance")
					gold_balance=$((gold_balance + 100))
					dialogue_event="Your late relative has left an inheritance of ${YELLOW}100${RESET} coins to you."
					;;
				
				# Multiplier Boost: Increase multiplier by 0.5x.
				"Multiplier Boost")
					multiplier=$((multiplier + 50))
					dialogue_event="You won a few dealings... Your multiplier has increased by ${GREEN}0.5x${RESET}."

					if [[ "$max_multiplier" -lt "$multiplier" ]]
					then
						max_multiplier="$multiplier"
					fi
					;;
				
				# Unlucky Day: Lose 50 coins.
				"Unlucky Day")
					if [[ "$active_item" == "Event Insurance" ]]
					then
						dialogue_event="Event Insurance has protected you from an Unlucky Day."
					elif [[ "$active_item" != "Event Insurance" ]]
					then
						gold_balance=$((gold_balance - 50))
						dialogue_event="You tried to deal with a shady dealer and lost ${YELLOW}50${RESET} coins."
					fi
					;;
				
				# Mysterious Gift: Gain a mystery item if your inventory is not full.
				"Mysterious Gift")
					if [[ "${#inventory[@]}" -lt 3 ]]
					then
						inventory+=("Mystery Item")
						dialogue_event="A man in a dark cloak hands you a gift: ${PURPLE}Mystery Item${RESET}."
					else
						dialogue_event="A man in a dark cloak offers you a gift... You decline, as your inventory is full."
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
					dialogue_event="You found a lost wallet with ${YELLOW}50${RESET} coins."
					;;
				
				# Wheel of Fortune: Randomly gain or lose 50% of your current gold balance.
				"Wheel of Fortune")
					local fortune_outcome=$((RANDOM % 2))
					if [[ "$fortune_outcome" -eq 0 ]]
					then
						if [[ "$active_item" == "Event Insurance" ]]
						then
							dialogue_event="Event Insurance has protected you from a loss on the Wheel of Fortune."
						elif [[ "$active_item" != "Event Insurance" ]]
						then
							local loss_amount=$((gold_balance / 2))
							gold_balance=$((gold_balance - loss_amount))
							dialogue_event="The Wheel of Fortune was unlucky! You lost ${YELLOW}$loss_amount${RESET} coins."
						fi
					else
						local gain_amount=$((gold_balance / 2))
						gold_balance=$((gold_balance + gain_amount))
						dialogue_event="The Wheel of Fortune was lucky! You gained ${YELLOW}$gain_amount${RESET} coins."
					fi
					;;
				
				# Bankruptcy: Lose 50% of your current gold balance.
				"Bankruptcy")
					if [[ "$active_item" == "Event Insurance" ]]
					then
						dialogue_event="Event Insurance has protected you from Bankruptcy."
					elif [[ "$active_item" != "Event Insurance" ]]
					then
						local loss_amount=$((gold_balance / 2))
						gold_balance=$((gold_balance - loss_amount))
						dialogue_event="You went bankrupt! You lost ${YELLOW}$loss_amount${RESET} coins."
					fi
					;;
				
				# Slot Machine: Randomly gain between 10 and 50 coins.
				"Slot Machine")
					local slot_gain=$((RANDOM % 41 + 10))
					gold_balance=$((gold_balance + slot_gain))
					dialogue_event="You played the slot machine and won ${YELLOW}$slot_gain${RESET} coins."
					;;
			esac

			# Reset Event Insurance if event is encountered
			if [[ "$active_item" == "Event Insurance" ]]
			then
				active_item="..."
			fi
		fi
	else
		current_event="..."
		dialogue_event="..."
	fi
}

reset_shop() {
	clear

	# Check if round is a multiple of 5 or if Magic Dice is used
	if [[ $((round % 5)) -eq 0 || "$active_item" == "Magic Dice" ]]
	then
		if [[ "$round" -ne "$current_round" || "$active_item" == "Magic Dice" ]]
		then
			current_round="$round"
			current_shop=()
			current_shop_costs=()
			shop_item1_purchased=0
			shop_item2_purchased=0
			shop_item3_purchased=0

			# Append 3 items to current_shop array
			# Append 3 corresponding item costs to current_shop_costs array
			for (( i=0; i<3; i++ ))
			do
				local shop_index=$((RANDOM % ${#shop_catalogue[@]}))
				current_shop+=("${shop_catalogue[$shop_index]}")
				current_shop_costs+=("${shop_catalogue_costs[$shop_index]}")
			done
		fi
	fi
}

display_shop() {
	clear

	# Reset Magic Dice if item is used
	if [[ "$active_item" == "Magic Dice" ]]
	then
		active_item="..."
	fi

	cat <<- EOF
	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	${RED}The Shop${RESET}
	~~~ NOTICE: The inventory is limited to three items. ~~~
	
	EOF

	# Check shop_item1 purchase status
	if [[ shop_item1_purchased -eq 0 ]]
	then

		# Display shop costs
		printf "Item: ${PURPLE}%s${RESET}\n" "${current_shop[0]}"
		if [[ "$active_item" == "Shop Coupon" ]]
		then
			printf "Cost: ${YELLOW}%s${RESET} coins\n\n" "$((${current_shop_costs[0]} / 2))"
		else
			printf "Cost: ${YELLOW}%s${RESET} coins\n\n" "${current_shop_costs[0]}"
		fi
	else

		# Strikethrough shop costs
		printf "${STRIKETHROUGH}Item: %s${RESET}\n" "${current_shop[0]}"
		printf "${STRIKETHROUGH}Cost: %s coins${RESET}\n\n" "${current_shop_costs[0]}"
	fi

	# Check shop_item2 purchase status
	if [[ shop_item2_purchased -eq 0 ]]
	then

		# Display shop costs
		printf "Item: ${PURPLE}%s${RESET}\n" "${current_shop[1]}"
		if [[ "$active_item" == "Shop Coupon" ]]
		then
			printf "Cost: ${YELLOW}%s${RESET} coins\n\n" "$((${current_shop_costs[1]} / 2))"
		else
			printf "Cost: ${YELLOW}%s${RESET} coins\n\n" "${current_shop_costs[1]}"
		fi
	else

		# Strikethrough shop costs
		printf "${STRIKETHROUGH}Item: %s${RESET}\n" "${current_shop[1]}"
		printf "${STRIKETHROUGH}Cost: %s coins${RESET}\n\n" "${current_shop_costs[1]}"
	fi

	# Check shop_item3 purchase status
	if [[ shop_item3_purchased -eq 0 ]]
	then

		# Display shop costs
		printf "Item: ${PURPLE}%s${RESET}\n" "${current_shop[2]}"
		if [[ "$active_item" == "Shop Coupon" ]]
		then
			printf "Cost: ${YELLOW}%s${RESET} coins\n\n" "$((${current_shop_costs[2]} / 2))"
		else
			printf "Cost: ${YELLOW}%s${RESET} coins\n\n" "${current_shop_costs[2]}"
		fi
	else

		# Strikethrough shop costs
		printf "${STRIKETHROUGH}Item: %s${RESET}\n" "${current_shop[2]}"
		printf "${STRIKETHROUGH}Cost: %s coins${RESET}\n\n" "${current_shop_costs[2]}"
	fi

	cat <<- EOF
	You currently have ${YELLOW}$gold_balance${RESET} coins.

	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	EOF

	# Display user options
	echo -e "${RED}[1]${RESET} Buy ${current_shop[0]}"
	echo -e "${RED}[2]${RESET} Buy ${current_shop[1]}"
	echo -e "${RED}[3]${RESET} Buy ${current_shop[2]}"
	echo -e "${RED}[4]${RESET} Return to Game"

	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
	do

		# Get user input
		read -p " >  " choice
		case "$choice" in
			1)
				# Check shop_item1 purchase status
				if [[ shop_item1_purchased -eq 0 ]]
				then

					# Check if gold is sufficient to purchase item
					if [[ "$gold_balance" -ge "${current_shop_costs[0]}" ]]
					then

						# Check if inventory is full
						if [[ "${#inventory[@]}" -lt 3 ]]
						then

							# Add item to inventory
							# Subtract cost from gold_balance
							inventory+=("${current_shop[0]}")
							gold_balance=$((gold_balance - current_shop_costs[0]))
							shop_item1_purchased=1

							# Reset Shop Coupon if item is used
							if [[ "$active_item" == "Shop Coupon" ]]
							then
								active_item="..."
							fi
							clear
							
							# Display current inventory
							echo -e "You have purchased ${PURPLE}${current_shop[0]}${RESET}.\n"
							echo "Your current inventory contains:"
							for item in "${inventory[@]}"
							do
								printf "${PURPLE}%s${RESET}\n" "$item"
							done

							echo -e "\nYou have ${YELLOW}$gold_balance${RESET} coins left."
							echo -e "\n${RED}[1]${RESET} Return to Game"

							choice=""
							while [[ "$choice" -ne 1 && "$choice" -ne 2 ]]
							do
								read -p " >  " choice
								case "$choice" in
									1)
										return
										;;
									*)
										echo -e "${RED}Enter a valid numerical input.${RESET}"
										;;
								esac
							done
						else
							echo -e "${RED}Your inventory is currently full.${RESET}"
							choice=0
						fi
					else
						echo -e "${RED}You do not have enough coins to purchase this item.${RESET}"
						choice=0
					fi
				else
					echo -e "${RED}You have already purchased this item.${RESET}"
					choice=0
				fi
				;;
			2)
				# Check shop_item2 purchase status
				if [[ shop_item2_purchased -eq 0 ]]
				then

					# Check if gold is sufficient to purchase item
					if [[ "$gold_balance" -ge "${current_shop_costs[1]}" ]]
					then

						# Check if inventory is full
						if [[ "${#inventory[@]}" -lt 3 ]]
						then

							# Add item to inventory
							# Subtract cost from gold_balance
							inventory+=("${current_shop[1]}")
							gold_balance=$((gold_balance - current_shop_costs[1]))
							shop_item2_purchased=1

							# Reset Shop Coupon if item is used
							if [[ "$active_item" == "Shop Coupon" ]]
							then
								active_item="..."
							fi
							clear
							
							# Display current inventory
							echo -e "You have purchased ${PURPLE}${current_shop[1]}${RESET}.\n"
							echo "Your current inventory contains:"
							for item in "${inventory[@]}"
							do
								printf "${PURPLE}%s${RESET}\n" "$item"
							done

							echo -e "\nYou have ${YELLOW}$gold_balance${RESET} coins left."
							echo -e "\n${RED}[1]${RESET} Return to Game"

							choice=""
							while [[ "$choice" -ne 1 && "$choice" -ne 2 ]]
							do
								read -p " >  " choice
								case "$choice" in
									1)
										return
										;;
									*)
										echo -e "${RED}Enter a valid numerical input.${RESET}"
										;;
								esac
							done
						else
							echo -e "${RED}Your inventory is currently full.${RESET}"
							choice=0
						fi
					else
						echo -e "${RED}You do not have enough coins to purchase this item.${RESET}"
						choice=0
					fi
				else
					echo -e "${RED}You have already purchased this item.${RESET}"
					choice=0
				fi
				;;
			3)
				# Check shop_item3 purchase status
				if [[ shop_item3_purchased -eq 0 ]]
				then

					# Check if gold is sufficient to purchase item
					if [[ "$gold_balance" -ge "${current_shop_costs[2]}" ]]
					then

						# Check if inventory is full
						if [[ "${#inventory[@]}" -lt 3 ]]
						then

							# Add item to inventory
							# Subtract cost from gold_balance
							inventory+=("${current_shop[2]}")
							gold_balance=$((gold_balance - current_shop_costs[2]))
							shop_item3_purchased=1

							# Reset Shop Coupon if item is used
							if [[ "$active_item" == "Shop Coupon" ]]
							then
								active_item="..."
							fi
							clear
							
							# Display current inventory
							echo -e "You have purchased ${PURPLE}${current_shop[2]}${RESET}.\n"
							echo "Your current inventory contains:"
							for item in "${inventory[@]}"
							do
								printf "${PURPLE}%s${RESET}\n" "$item"
							done

							echo -e "\nYou have ${YELLOW}$gold_balance${RESET} coins left."
							echo -e "\n${RED}[1]${RESET} Return to Game"

							choice=""
							while [[ "$choice" -ne 1 && "$choice" -ne 2 ]]
							do
								read -p " >  " choice
								case "$choice" in
									1)
										return
										;;
									*)
										echo -e "${RED}Enter a valid numerical input.${RESET}"
										;;
								esac
							done
						else
							echo -e "${RED}Your inventory is currently full.${RESET}"
							choice=0
						fi
					else
						echo -e "${RED}You do not have enough coins to purchase this item.${RESET}"
						choice=0
					fi
				else
					echo -e "${RED}You have already purchased this item.${RESET}"
					choice=0
				fi
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

view_inventory() {
	clear

	cat <<- EOF
	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	${RED}The Inventory${RESET}
	Your inventory contains the following items:

	EOF
	
	# Display current inventory
	for item in "${inventory[@]}"
	do
		printf "${PURPLE}%s${RESET}\n\n" "$item"
	done

	cat <<- EOF
	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	EOF

	# Display user options to use items
	for (( i=0; i<${#inventory[@]}; i++ ))
	do
		echo -e "${RED}[$((i + 1))]${RESET} Use ${inventory[$i]}"
	done
	echo -e "${RED}[$((${#inventory[@]} + 1))]${RESET} Return to Game"

	local choice=""
	while true
	do
		read -p " >  " choice

		# Check if user input is valid
		if [[ "$choice" -ge 1 && "$choice" -le $((${#inventory[@]} + 1)) ]]
		then
			break
		else
			echo -e "${RED}Enter a valid numerical input.${RESET}"
		fi
	done

	# Check if user input is to use an item
	if [[ "$choice" -le ${#inventory[@]} ]]
	then

		# Set active_item to used item
		# Remove item from array and reindex
		active_item=${inventory[$((choice - 1))]}
		unset "inventory[$((choice - 1))]"
		inventory=("${inventory[@]}")
		total_items=$((total_items_used + 1))

		if [[ "$active_item" == "Cursed Token" ]]
		then
			local cursed_token_loss=$((gold_balance / 4))
			gold_balance=$((gold_balance - cursed_token_loss))
			multiplier=$((multiplier + 100))

			if [[ "$max_multiplier" -lt "$multiplier" ]]
			then
				max_multiplier="$multiplier"
			fi
		fi

		if [[ "$active_item" == "Mystery Item" ]]
		then
			mystery_item
		fi

	else
		return
	fi
}

mystery_item() {
	clear

	# Display user options for Mystery Item
	cat <<- EOF
	${RED}A dark cloud envelops the room...${RESET}


	           ${WHITE}Option 1${RESET}
	${WHITE}==============================${RESET}
	
	${GREEN}Gold:${RESET} Gain ${YELLOW}25%${RESET} of your
	gold balance immediately

	${RED}Multiplier:${RESET} Permanently reset and
	cap your multiplier at ${GREEN}x1.0${RESET}

	${WHITE}==============================${RESET}


		        ${WHITE}Option 2${RESET}
	${WHITE}==============================${RESET}
	
	${GREEN}Gold:${RESET} Gain ${YELLOW}1000${RESET} coins
	instantly

	${RED}Streak:${RESET} Instantly reset
	your streak to ${CYAN}0${RESET}

	${WHITE}==============================${RESET}


		        ${WHITE}Option 3${RESET}
	${WHITE}==============================${RESET}
	
	${GREEN}Multiplier:${RESET} Instantly set your
	multiplier to ${GREEN}x3.0${RESET} (Non-Permanent)

	${RED}Gold:${RESET} Lose ${YELLOW}25%${RESET} of your
	gold balance immediately

	${WHITE}==============================${RESET}

	EOF

	# Display user options
	echo -e "${RED}[1]${RESET} Select Option 1"
	echo -e "${RED}[2]${RESET} Select Option 2"
	echo -e "${RED}[3]${RESET} Select Option 3"
	echo -e "${RED}[4]${RESET} Select None"

	local choice=""

	# Check if user input is valid
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				gold_balance=$((gold_balance + gold_balance / 4))
				multiplier=100
				multiplier_cap=1
				active_item="..."
				;;
			2)
				gold_balance=$((gold_balance + 1000))
				streak=0
				active_item="..."
				;;
			3)
				multiplier=300
				gold_balance=$((gold_balance - gold_balance / 4))
				active_item="..."

				if [[ "$max_multiplier" -lt "$multiplier" ]]
				then
					max_multiplier="$multiplier"
				fi
				;;
			4)
				active_item="..."
				return
				;;
			*)
				echo -e "${RED}Enter a valid numerical input${RESET}"
				;;
		esac
	done
}

view_index() {
	clear

	# Display all items and usage information
	cat <<- EOF
	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	${RED}The Index${RESET}
	~~~ NOTICE: All items must be ACTIVE for effects to apply. ~~~
	An index containing information on useable items:

	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	1. ${PURPLE}Bet Insurance${RESET}
	   Lose 50% of your next bet, given that it is a loss;
	   Resets on round end
	
	2. ${PURPLE}4-Leafed Clover${RESET}
	   Guarantees a win on your next bet;
	   Resets on round end

	3. ${PURPLE}Event Insurance${RESET}
	   Guards against the next instance of coin loss from an event;
	   Does not reset on round end
	
	4. ${PURPLE}Magic Dice${RESET}
	   Rerolls the current shop, offering three new items;
	   Does not reset on round end
	
	5. ${PURPLE}Double Down Voucher${RESET}
	   Gain double or lose double on your next bet;
	   Resets on round end
	
	6. ${PURPLE}Lucky Coin${RESET}
	   Refund your next bet, given that it is a loss;
	   Resets on round end

	7. ${PURPLE}Shop Coupon${RESET}
	   Gain a 50% discount on your next shop purchase;
	   Does not on round end

	8. ${PURPLE}Cursed Token${RESET}
	   Gain plus x1.0 multiplier, but lose 25% of your current gold balance;
	   Does not reset on round end

	9. ${PURPLE}Mystery Item${RESET}
	   ???

	EOF

	# Display user options
	echo -e "${RED}[1]${RESET} Return to Game"

	local choice=""
	while [[ "$choice" -ne 1 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				return
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

# =============================================================
# MAIN GAME UI
# =============================================================
game_banner() {
	echo -e "${RED}"
	cat <<- "EOF"
	===========================================================================
	===========================================================================
	                    ___ ___ ___ _  _   ___ _    ___ ___ 
	                   / __/ _ \_ _| \| | | __| |  |_ _| _ \
	                  | (_| (_) | || .` | | _|| |__ | ||  _/
	                   \___\___/___|_|\_| |_| |____|___|_|
	===========================================================================
	===========================================================================
	EOF
	echo -e "${RESET}"
}

player_stats() {
	echo -e "👤 Player Name: ${WHITE}$player_name${RESET}\n"
	printf "🪙  Gold Balance: ${YELLOW}%-18s${RESET} ❌ Multiplier: ${GREEN}%-18s${RESET}" "$gold_balance" "$(display_multiplier)"
	printf "\n⏰ Round Number: ${BLUE}%-18s${RESET} 🔥 Streak: ${CYAN}%-18s${RESET}" "$((round + 1))" "$streak"
	printf "\n🎲 Current Event: ${PURPLE}%-17s${RESET} ♟️  Active Item: ${PURPLE}%-18s${RESET}" "$current_event" "$active_item"
	echo -e "\n${RED}===========================================================================${RESET}"
}

dialogue_box() {
	cat <<- EOF

	💬 ${dialogue_bet}
	💬 ${dialogue_multiplier}
	💬 ${dialogue_event}

	${RED}===========================================================================${RESET}

	EOF
}

player_options() {

	# Display use roptions
	echo -e "${RED}[1]${RESET} Place Bet"
	echo -e "${RED}[2]${RESET} View Inventory"
	echo -e "${RED}[3]${RESET} View Item Index"
	echo -e "${RED}[4]${RESET} View Shop"
	echo -e "${RED}[5]${RESET} Exit to Main Menu"

	local choice=""
	while [[ "$choice" -ne 1 && "$choice" -ne 2 && "$choice" -ne 3 && "$choice" -ne 4 ]]
	do
		read -p " >  " choice
		case "$choice" in
			1)
				place_bet
				;;
			2)
				view_inventory
				;;
			3)
				view_index
				;;
			4)
				display_shop
				;;
			5)
				main_menu
				;;
			*)
				echo -e "${RED}Enter a valid numerical input.${RESET}"
				;;
		esac
	done
}

# =============================================================
# GAME END SCREENS
# =============================================================
game_over() {
	clear

	# Display user options
	echo -e "${RED}$GAME_OVER_TITLE${RESET}\n"
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

game_win() {
	clear

	cat <<- EOF
	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	${RED}Player Stats${RESET}

	Player Name: ${WHITE}$player_name${RESET}

	Time of completion: ${WHITE}$(date "+%H:%M:%S")${RESET}
	                    ${WHITE}$(date "+%m-%d-%Y")${RESET}
	Time Spent: ${WHITE}$SECONDS${RESET} seconds

	Highest Gold Balance Achieved: ${YELLOW}$gold_balance${RESET}

	Highest Round Achieved: ${BLUE}$round${RESET}

	Highest Multiplier Achieved: ${GREEN}$(display_max_multiplier)${RESET}

	Highest Streak Achieved: ${CYAN}$max_streak${RESET}

	Total Events Encountered: ${PURPLE}$total_events${RESET}

	Total Items Used: ${PURPLE}$total_items${RESET}

	${RED}===========================================================================${RESET}
	${RED}===========================================================================${RESET}

	EOF

	# Display user options
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

# Display main menu to start game
main_menu