local function find_clear(sudoku)
	for i = 1, 9 do
		for j = 1, 9 do
			if sudoku[i][j] == 0 then
				return i, j;
			end
		end
	end
end

local function safe(sudoku, i, j, val)
	for k = 1, 9 do
		if j ~= k and sudoku[i][k] == val or i ~= k and sudoku[k][j] == val then
			return false;
		end
	end
	local start_i, start_j = i - ((i-1) % 3), j - ((j-1) % 3);
	for k = start_i, start_i + 2 do
		for _k = start_j, start_j + 2 do
			if (k ~= i or _k ~= j) and sudoku[k][_k] == val then
				return false;
			end
		end
	end
	return true;
end

local function solve(sudoku)
	local i, j = find_clear(sudoku);
	if not i then return true; -- solved
	end
	for val = 1, 9 do
		if safe(sudoku, i, j, val) then
			sudoku[i][j] = val;
			if solve(sudoku) then return true;
			end
			sudoku[i][j] = 0;
		end
	end
	return false;
end

local function print_sudoku(sudoku)
	for i = 1, 9 do
		print(table.concat(sudoku[i], ' '));
	end
end

local read = io.read;
local sudoku = { };
for i = 1, 9 do
	local t = { };
	for j = 1, 9 do
		t[j] = read'*n';
	end
	sudoku[i] = t;
end

print'------------------------------------------------------';
if solve(sudoku) then
	print_sudoku(sudoku);
else
	print'ERROR!';
end
read'*n';
