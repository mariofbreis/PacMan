# PacMan
 Project for Computer Architecture

This work was done in assembly programming language and was subsequently assembled and run in the p3 processor simulator. The realization of this work contributed in a fundamental way to the understanding of the programming language in question and to the understanding of the functioning of a processor.

The project carried out consisted of programming the famous assembly pac-man game. The game aims to get the highest score possible. The player controls the pac-man, this being an “@”, when eating “.” (points) adds 2 points, when you eat “(“ (banana) adds 10, if you eat an “&” (pear) adds 20, finally when eating an “%” adds 30 points to the current score of the level in question, which can also be accumulated to the final score. As he accumulates points, pac-man and monsters move faster. To make this “adventurer’s” task more difficult, there are all the cost to prevent our "friend" from accumulating points. When the pac-man is caught by a monster the game is over and the maximum score (if it is higher than the one I had previously) is shown in the home menu. In addition, the game contains 3 levels, the 1st being the easiest and the 3rd the hardest.

The pac-man movement map in each level is delimited by “#” (walls), not allowing him to leave the map and eat what he shouldn't.

# Menu

The initialization of the initial menu consists of the presentation of the following strings in the p3 simulator text window:
- "Pac-Man Game"
- “Maximum score: x” (where x is the maximum score reached by the user)
- "Use the levers to choose the initial level and then press a key."
In order to write the strings previously mentioned, the memory position of the IO_WRITE is used. Once the strings previously mentioned are written in the p3 simulator text window, the user is expected to click on a key, which, depending on the levers activated, loads one of the levels in the text window, deleting what was written in the menu. To activate level 1 the value of the two levers (the ones on the right) must be 00, if the desired level is the 2nd the value of the same two levers must be 01, finally to load the 3rd level this value must be 10.

# Game

The game starts with the map corresponding to the level that the user wants to play. On the right side of the map, another 4 strings are also loaded, one informing the game which game it is about, another informing what level the user is on and finally two asking the user to press a key in order to initialize the timer that controls the movement of the game and pac-man, thus starting the game.

- "Pac-Man Game"
- "Level 1"
- “Press a key to
- "start the game."

After pressing a key, the last string is deleted and the timer is started, allowing pac-man movement. Thus, pac-man moves to the right so the user presses the “p” key, forward when pressing the “w”, backward when the “s” is pressed and, finally, and once missing the left is when the user presses the “o” key. These keys initiate the interruptions associated with them. In order to explain more about pac-man movement, when the map is loaded in the text window it is also loaded into memory to be able to test what is associated with the next position in order to add points if necessary and, for stop the movement if you see a wall or give Game Over if the pac-man finds the monster. As the score increases, pac-man speed also increases. Regarding the movement of the monster, it has not been fully completed. However, in the MONSTROS_INIC function, the positions of each one on each map were initialized in memory, and the random function was translated into a micro-instruction that is in operation.

# Level change

After completing the level, the user asks to press a key to change to the next level, without asking the user which level to go to. The LED score, like the speed, is updated only during the level, the current score is also initialized, updating at the end the maximum score if the current score is higher than the maximum score saved. The only chance to choose a level change is at the beginning of the game, and in case the pac-man meets the monster, in this case the string “Game Over :(” is printed, returning to the initial menu.
