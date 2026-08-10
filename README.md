# Coin Flip Roguelite
This is a simple coin flip-based roguelite game in the Terminal that I made.

## How to Install
To run this Bash shell script, you will need a shell that is able to interpret Bash.

There are a few ways to achieve this:

1. Install Windows Subsystem for Linux (WSL)
    1. Navgiate to Start and search for Terminal.
    2. Inside your Terminal, enter wsl --install.
    3. Restart your computer, then launch Terminal again.
    4. Enter wsl.exe --install `<Distro>` (Ubuntu is recommended; This installs Ubuntu as your Linux distribution)
    5. After the installation finishes, set up your `<Distro>` username and password.
    6. Update and upgrade your `<Distro>` by using: ```sudo apt update``` and ```sudo apt upgrade``` (Optional but recommended).
    7. Download the script file and navigate to the directory that contains it by using ```cd file-path``` (cd stands for change directory or folder; For example, if you saved the script file to your downloads folder, you might use ```cd /mnt/c/Users/Username/Downloads```).
        1. Alternatively, you could use ```git clone https://github.com/dumdirt/coin-flip-roguelite.git``` in Terminal to clone the contents of the repository onto your local computer. Do be sure to navigate to the directory all the same though.
    8. Next, run ```chmod +x coin-game.sh``` to grant the executable permissions (only if you are going to use ./coin-game.sh in step 9).
    9. Lastly, use ```./coin-game.sh``` or ```bash coin-game.sh``` to run the script in Terminal or any code editor integrated terminal.
    10. Enjoy the game! :)

2. Install Git Bash
    1. In your browser, search for Git for Windows.
    2. Install Git Bash.
    3. Download the script file and navigate to the directory, using ```cd file-path``` (cd stands for change directory or folder; For example, using ```cd /c/Users/Username/Downloads``` would take you to the downloads folder on your computer).
        1. You could otherwise use ```git clone https://github.com/dumdirt/coin-flip-roguelite.git``` in Terminal to clone the repository's contents onto your local computer. Of course, do remember to navigate to the directory containing the script file.
    4. Run ```chmod +x coin-game.sh``` to grant the script executable permissions (only if you are going to use ./scriptname.sh in step 9).
    5. Use ```./coin-game.sh``` or ```bash coin-game.sh``` to run the script in Terminal or any integrated terminal in a code editor.
    6. Please enjoy! :)

## How to Play
### General Information
This game features two modes: Standard and Infinite.

In each mode, the player will start with 100 coins, a multiplier of x1.0, a streak of 0, and at round 1.

Standard mode runs until the player reaches a gold balance of greater than or equal to 10,000 gold coins, and infinite mode runs on indefinitely as the name suggests.
### Betting System
Each Round, you will be asked to place a bet greater than or equal to 10 gold coins. Then you will be asked to predict the outcome of a coin flip: heads or tails.

A correct bet will earn you your wager multiplied by your multiplier, and an incorrect bet will lose you your wager.

### Shop System
On the first round and every round that is a multiple of 5, the shop will reset, offering three new items for purchase. Each item will have a unique effect on your gameplay. 

Items can only be purchased once before the shop resets.

### Inventory System
The player's inventory is allowed a maximum of 3 items at once. When an item is consumed, it disappears from the player's inventory.

Items' effects will only apply if they are the 'active item' in play.

### Event System
Every 5 rounds, excluding the first, a special event will take place, impacting the player's gameplay.

Events range from a simple gold increase or decrease to a multiplier or streak reset.

## Credits
This game was made by me, dirtblock or dumdirt.

It was definitely a learning process while making this script.