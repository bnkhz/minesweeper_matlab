%creation of a function that detects right and left click
function bandeiras(clicked_object, ~)
% Initialize the flag variable
% using the UI that my gf made in the samecarpet as the minesweeper project
    imgbanderas = imread('flag.png'); imgcelda = imread('cell.png');
    imgtriste = imread('sad_face.png');
    
    figura = gcbf;
    clickType = get(figura, 'Selectiontype');
    % if button is already open, we dont do nothing
    if strcmp(get(clicked_object, 'Enable'), 'inactive')
        return;
    end
    %If to let know the code which click is using
    if strcmp(clickType, 'normal') %normal  = right click
        if strcmp(get(clicked_object, 'Tag'), 'con_bandera')
            return; 
        end
        % Open the cell and update the display
        open_cell(clicked_object);
        % We check if the player touch a bomb
        contenido = get(clicked_object, 'UserData');
        if ischar(contenido) && strcmp(contenido, 'MINA')
            h_carita = findobj('Tag', 'boton_carita'); 
            set(h_carita, 'CData', imgtriste)
            disp('BOOM! CHAKALAKA!')

            pause(1);  % Wait for the player see the tragedy    
            close(figura); %close the code 
            minesweeper(); % Restart the game automatically
        else 
            % Update the game state and check for a win condition
            win_check(figura);
        end


    elseif strcmp(clickType, 'alt') %left click
        %right click: put/take out the flag
        if strcmp(get(clicked_object, 'Tag'), 'con_bandera')
            % Toggle the flag state
            set(clicked_object, 'Tag', 'sin_bandera');
            set(clicked_object, 'CData', imgcelda);
        else
            set(clicked_object, 'Tag', 'con_bandera');
            set(clicked_object, 'CData', imgbanderas);
        end
    end
end
% Function to check if the person win the game
function win_check(figura)
%searching all buttons in the window
    todos_botones =findobj(figura, 'Style', 'pushbutton');
    
    total_cells = 0;
    open_cells_ = 0;
    mines = 0;
    % We visit all buttons for counting, help of AI
    for i = 1:length(todos_botones)
        btn = todos_botones(i);
        tag = get(btn, 'Tag');
        if ~strcmp(tag, 'boton_carita')
            total_cells = total_cells + 1; 
            contenido = get(btn, 'UserData');
            if strcmp(get(btn, 'Enable'), 'inactive')
                open_cells_ = open_cells_ + 1; 
            end 
            if ischar(contenido) && strcmp(contenido, 'MINA')
                mines = mines + 1; 
            end 

        end
    end 
    

    %calc of opened and secured cells
    safe_cells = total_cells - mines;
   % if all cells are open, then we change the image of sad cat to a happy
   % cat
    if open_cells_ == safe_cells
        stop(timerfind) %stop clock
        h_carita =  findobj(figura, 'Tag', 'boton_carita');
        imgwin = imread('win_face.png');%smiling face
        set(h_carita, 'CData', imgwin);
        disp('Victory!!!!!!!!!!!!!!!!!')
        pause(5) 
        close(figura)
    end 
end

        
    
% function to open the button and look inside
function open_cell(boton)
    contenido = get(boton, 'UserData'); 

    set(boton, 'CData', []);%delete the cover image
    set(boton, 'Enable', 'inactive'); %here is to block the button
    set(boton, 'BackgroundColor', [1 1 1]); %white code in MATLAB
    
    bomb_img = imread('bomba.png'); 
    % If is a mine, we put red and the bomb image
    if ischar(contenido) && strcmp(contenido, 'MINA') 
        
        set(boton, 'CData', bomb_img);
        set(boton, 'BackgroundColor', 'red');
    elseif isnumeric(contenido) 
        if contenido > 0 %checks if the content is greater than  0
            set(boton, 'String', num2str(contenido));
  
            colores = {'blue', [0 0.5 0], 'red', [0 0 0.7], [0.5 0 0]};     
            if contenido <= length(colores)
             set(boton, 'ForegroundColor', colores{contenido});
            end
            set(boton, 'FontSize', 14, 'FontWeight', 'bold');
        %%%%% Reveal cells, we dont made this algorythm we ask chatgpt to
        %%%%% do it for us, ALGORYTHM CALLED "FLOOD FILL"
        elseif contenido == 0
            figura = gcbf;
            if isempty(figura)
                figura = get(boton, 'Parent');
            end
            

            botones_grid = get(figura, 'UserData');
            

            if isempty(botones_grid)
                return; 
            end
            
            [rows_total, cols_total] = size(botones_grid);
            

            [row, col] = find(botones_grid == boton);
            

            if isempty(row)
                return;
            end
            for i = -1:1
                for j = -1:1
                    neighbor_row = row + i;
                    neighbor_col = col + j;
                    if neighbor_row >= 1 && neighbor_row <= rows_total && ...
                       neighbor_col >= 1 && neighbor_col <= cols_total

                       neighbor_button = botones_grid(neighbor_row, neighbor_col);
                       estatus = get(neighbor_button, 'Enable');
                       tag = get(neighbor_button, 'Tag');
                        
                       if strcmp(estatus, 'on') && ~strcmp(tag, 'con_bandera')
                            open_cell(neighbor_button);
                       end
                    end
                end
            end
        end
    end
end

