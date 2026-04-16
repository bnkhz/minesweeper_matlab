HELLO THIS IS THE PROJECT MINESWEEPER
-------------------------------------

We made the classic minesweeper game in MATLAB, but with a custom design.

WHAT WE DID:
1. The images: Christopher's friend draw all the icons and the cells. We have sad face (mostly the entire game), sad face (game over) and a cool happy face (Victory). Also the flags and bombs.
2. The grid: It is 16x16 with 20 mines. There is no difficulty selection, we are sorry for that.
3. The logic: 
   - Left click: Open the cell.
   - Right click: Put the flag (protection).
   - If you click number 0, the game open neighbor cells automatic (Flood Fill algorithm). This was difficult but now works good, this was with the help of AI.

FILES IN THE FOLDER:
- minesweeper.m: The main code body, open the window and the timer.
- bandeiras.m: The logic for clicks, win and loose conditions.
- mine_generator.m: Math to put bombs random.
- crear_reloj.m: The timer configuration.
- main.m: Opens the game file.
- images: cell, flag, bomb, faces.

HOW TO PLAY:
Run "minesweeper" in command window. 
Click the happy face to restart if you loose.
If you open all safe cells, the time stop and you win.

Hope you like it.