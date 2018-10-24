%% SudokuProject_Chapel
clear all; close all;

%%%%%%%%%%%%%%%%% EXAMPLE PROBLEMS %%%%%%%%%%%%%%%%%%%
% % % 4x4 Example
% MatrixInitial = [0 0 4 0;
%                  1 0 0 0;
%                  0 0 0 3;
%                  0 1 0 0];
% % %MEDIUM LEVEL
% MatrixInitial = [0 5 0 0 2 0 3 7 0;
%                  0 3 0 9 4 0 0 0 1;
%                  0 0 0 7 0 0 0 0 0;
%                  0 0 5 8 0 0 9 2 0;
%                  3 0 0 0 0 0 0 0 5;
%                  0 7 8 0 0 9 1 0 0;
%                  0 0 0 0 0 2 0 0 0;
%                  8 0 0 0 7 6 0 5 0;
%                  0 2 1 0 8 0 0 6 0];

% %EVIL LEVEL
% MatrixInitial = [0 6 9 7 0 0 4 3 0;
%                  0 1 0 0 0 0 0 7 0;
%                  3 0 0 0 0 5 0 0 2;
%                  0 3 0 0 0 0 0 0 1;
%                  0 0 0 0 9 0 0 0 0;
%                  6 0 0 0 0 0 0 2 0;
%                  7 0 0 2 0 0 0 0 3;
%                  0 9 0 0 0 0 0 4 0;
%                  0 4 2 0 0 3 5 1 0];

%EVIL LEVEL
MatrixInitial = [0 9 0 4 0 8 5 0 0;
                 0 0 0 0 0 0 0 0 6;
                 2 0 1 0 7 0 9 0 0;
                 5 0 0 0 8 0 0 0 7;
                 0 0 7 9 0 4 1 0 0;
                 8 0 0 0 2 0 0 0 9;
                 0 0 2 0 3 0 4 0 5;
                 4 0 0 0 0 0 0 0 0;
                 0 0 5 8 0 7 0 9 0];

%%%%%%%%%%%% LIMITATIONS %%%%%%%%%%%%%%
% % 16x16 Easy Example %%DOES NOT WORK
% MatrixInitial = [0  0  3  6  0   8 0  0  5 14 0  9  0  0  0 15;
%                  0  1  2  7 11   0 0  6  0 8 12 16  5  14 13  9;
%                  9  0 14 13 15   1 2  7  0 4  3  0  10  8 12 16;
%                  16 10 8 12  9   0 0 13 15 0  2  7  11  4  3 6;
%                  6  11 4 3   0  10 8 12 9  5  14  0 15  0  0 7;
%                  7  0  1 0   0  11 4  3 0 10  0  12 9  5 14 13;
%                  13 9  5 14  0  0  0  2 6  0  0  0 16  0  0 12;
%                  12 0  10 8 13  9  5 14 7 15  1  2  6 11 4  3;
%                  3  0  0  4 12  0 10  0 13 9  5 14  0 0  1  0;
%                  2  7  0  0  0  6  0  4 12 16 0  0 13 9  5  14;
%                  0 13  0  0  2  7 15  1 0  6 11  4 12 0  10  8;
%                  0 12  0 10 14  0  9  5 2  7 15  1  3  6  0  4;
%                  4  0  6  0  0 12 16 10 0  0  9  0  0  0  0  1;
%                  1  2  7 15  4  3  6 11 8 12 16 10 14  0  9  0;
%                  0 14  0  9  1  2  0 15 4  0  6  0  8 12 16  10;
%                  10 8  0 16  5 14 13  0 0  2  0  0  4  3  6  11];

% % %16x16 Medium Example %%DOES NOT WORK
% MatrixInitial = [4  0  0  0  8  1 0  0 0 11 12  0  0  0 13  0;
%                  6  9  0 13  0  2 7  5 8  0  0 10 15 11  0 14;
%                  0 15 11 12  0  0 0  0 4  2  7  0  0  0 16 10 ;
%                  0  0  0 16 14  0 0 12 6  0  3 13  0  2  7  5;
%                  5  4  2  7 10  8 1 16 0 15 11  0  0  0  0 13;
%                  13 6  0  0  0  0 0  7 0  0  1  0  0 15  0 12;
%                  0 14 15  0  0  6 0  3 0  4  0  0 10  8  1 16;
%                  0  0  0  1 12  0 0  0 0  0  9  0  0  4  0  7;
%                  7  0  4  2 16 10 8  1 12 0 15 11 13  6  0  0;
%                  0 13  6  9  0  5 4  0 16 0  0  1 12 14  0  0;
%                  11 0  0  0  3 13 0  0  7 5  4  2 16 10  8  0;
%                  0  0  0  8  0 12 0 15  3 0  0  9  0  5  0  0;
%                  0  7  0  4  1  0 10 8 11 0 14  0  0  0  0  9;
%                  0  3  0  0  0  0  0 4  0 0  0  8  0  0 14  0;
%                  0 11 12  0  9  3 13 6  2 0  0  4  0 16 10  8;
%                  8  1 16  0  0  0  0 14 0 3 13  6  0  0  5  0];

% % %Hardest Sudoku Ever %%DOES NOT WORK
% MatrixInitial = [8 0 0 0 0 0 0 0 0;
%                  0 0 3 6 0 0 0 0 0;
%                  0 7 0 0 9 0 2 0 0;
%                  0 5 0 0 0 7 0 0 0;
%                  0 0 0 0 4 5 7 0 0;
%                  0 0 0 1 0 0 0 3 0;
%                  0 0 1 0 0 0 0 6 8;
%                  0 0 8 5 0 0 0 1 0;
%                  0 9 0 0 0 0 4 0 0];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(MatrixInitial);
NN = N*N; % Number Cells 

%NOTE: each cell has 9 possible numbers that can
%      be chosen.  So the first 9 variables refer
%      to cell (1,1).  If for example the (1,1) cell
%      is a 4, than x(1:9)=[0 0 0 1 0 0 0 0 0] etc
NNN = N*N*N; %Total number of binary variables x

% Find clues: Aclues*x=bclues
ArrayInitial = reshape(MatrixInitial', 1, NN); % Reshape initial matrix to array
bClues = zeros(NNN, 1); % b array for the clues
AClues = zeros(NNN,NNN); % A matrix for clues
for i = 1:NN
    cellVal = ArrayInitial(i);
    if cellVal ~= 0
        bClues((i-1)*N+cellVal) = 1;
        AClues((i-1)*N+cellVal,(i-1)*N+cellVal) = 1;
    end
end
arrayCheck = reshape(ArrayInitial, N, N)';

% Constrain one number in each space: ASpaces*x=bSpaces
bCells = ones(NN,1);
ACells = zeros(NN,NNN);
for i = 0:NN-1
    ACells(i+1, N*i+1:N*(i+1)) = 1;
end

% Eliminate duplicates in columns: AColumns*x=bColumns
bColumns = ones(NN,1);
AColumns = [];
for i = 1:N
    AColumns = [eye(NN) AColumns];
end
% Eliminate duplicates in rows: ARows*x=bRows
bRows = ones(NN,1);
for k = 0:N-1
    for i = 1:N
        for j = 0:N-1
            ARows(i+N*k, j*N+i+NN*k) = 1;
        end
    end
end

% Eliminate duplicates in NxN blocks
bBlocks = ones(NN,1);
n = sqrt(N);
for l = 0:n-1
    for h = 0:n-1
        for i = 0:N-1
            for j = 0:n-1
                for k = 0:n-1
                    ABlocks(i+1+(h*N)+(l*n*N), N*k+1+(j*NN)+i+(h*n*N)+(l*n*NN)) = 1;
                end
            end
        end
    end
end
    

%% Use CVX to Solve LP
% Add cvx files to path
addpath /Users/gabrielchapel/Downloads/cvx
addpath /Users/gabrielchapel/Downloads/cvx/structures
addpath /Users/gabrielchapel/Downloads/cvx/lib
addpath /Users/gabrielchapel/Downloads/cvx/functions
addpath /Users/gabrielchapel/Downloads/cvx/commands
addpath /Users/gabrielchapel/Downloads/cvx/builtins
cvx_begin
    cvx_precision low % Low precision for faster performance
        variables x(NNN) % Set up variables for LP
        minimize norm(x,1) % Linear program
        subject to % Constraints
            AClues * x == bClues;
            ACells * x == bCells;
            AColumns * x == bColumns;
            ARows * x == bRows;
            ABlocks * x == bBlocks;
cvx_end

% Binary array sorted by cells
for i = 0:NN-1
    binaryArray(i+1,1:N) = x(i*N+1:(i+1)*N);
end
% Array of cell values
for i = 1:NN
    ArrayFinal(i) = find(binaryArray(i,:));
end
% Solution
MatrixFinal = reshape(ArrayFinal, N,N)'