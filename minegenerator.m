%creation of the math behind the minesweeper table

function table = minegenerator(rows, columns, mine_number)

    table = zeros(rows, columns);
    %total cell calculations

    totalCells = rows * columns;
    if mine_number > totalCells
        error('Number of mines exceeds total cells.');
    end
    %creation of cell random cell position
    random_positions  = randperm(totalCells, mine_number);

    table(random_positions) =-1;


    % Initialize the count of adjacent mines for each cell
    for i = 1:rows
        for j = 1:columns
            if table(i, j) ~= -1 % If not a mine
                % Count adjacent mines
                adjacentMines = sum(sum(table(max(i-1,1):min(i+1,rows), max(j-1,1):min(j+1,columns)) == -1));
                table(i, j) = adjacentMines; % Store the count
            end
        end
    end
end 