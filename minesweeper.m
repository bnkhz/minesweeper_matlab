function minesweeper()
    % Initialize the game board and parameters
    rows_size = 16;
    columns_size = 16;
    numMines = 20; % Example number of mines
    gameBoard = zeros(rows_size, columns_size);% Create a board filled with zeros
    
    boton_carita_size = 70; %carita bottom size
    % size in pixels 
    paint_size =  32;
    boton_size = 36;
    carita_size = 64; 
    %size calc
    window_width = columns_size * boton_size + 40; 
    window_height = rows_size * boton_size + 120;
    
    %caritas position
    posX_carita = (window_width / 2) - (boton_carita_size/ 2);
    posY_carita = window_height - boton_carita_size - 10;

    %Interface creation of the minesweeper using the paint and board size
    %parameters
    fig = figure('Name', 'Minesweeper', ...
                     'NumberTitle', 'off', ...
                 'MenuBar', 'none', ...
                 'Position', [400, 200, window_width, window_height], ...
                 'Color', [1 0.75 0.8]); %pink code colors
    %image read    
    imgcelda =  imread('cell.png');
    %face to restart ui cpmtrpö
    uicontrol('Style', 'pushbutton', ...
        'Position', [posX_carita, posY_carita, boton_carita_size, boton_carita_size], ...
        'CData', imread('happy_face.png'), ... 
        'Tag', 'boton_carita', ... 
        'Callback', 'close(gcbf); minesweeper();');
    %display creation using txt

    txtTiempo = uicontrol('Style', 'text', ...
        'String', '000', ...
        'Position', [window_width/2 - 25, window_height - 40, 50, 25], ...
        'FontSize', 14, 'BackgroundColor', 'black', 'ForegroundColor', 'red');
    %we call the timer function
    reloj_creation(txtTiempo);
    
    %we call the minegenerator function 
    logic_map = minegenerator(rows_size, columns_size, numMines);
    botones_grid = zeros(rows_size, columns_size);
    

    for f = 1:rows_size
        for c = 1:columns_size
            %making for loops to the square of the buttons and the
            %calcultation of each button in the square
            posX = (c-1) * boton_size + 20; 
            posY = (f-1) * boton_size + 20; 

            %interactive button 
            boton = uicontrol('Style', 'pushbutton', ...
                                 'Position', [posX, posY, boton_size, boton_size], ...
                                 'CData', imgcelda, ...
                                 'Callback', @bandeiras, 'ButtonDownFcn', @bandeiras);
            
            valor = logic_map(f,c);
            if valor == -1
                set(boton, 'UserData', 'MINA')
            else 
                set(boton, 'UserData', valor)
            end
            botones_grid(f, c) = boton; 
           
        end
    end
    set(fig, 'UserData', botones_grid);

end