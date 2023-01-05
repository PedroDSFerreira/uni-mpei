clc
clear all
close all

%-----RUN INIT.M FILE FIRST!-----
load 'vars.mat'

id = input('Insert User ID (1 to 943): ');
% If the user ID is not valid, the program will ask for a new one
while id < 1 || id > 943
    id = input('Invalid User ID. Insert User ID (1 to 943): ');
end

while true
    % Menu options
    disp('1 - Your movies');
    disp('2 - Suggestion of movies based on other users');
    disp('3 - Suggestion of movies based on already evaluated movies');
    disp('4 - Search Title');
    disp('5 - Exit');

    opt = input('Select choice: ');

    % If the option is not valid, the program will ask for a new one
    while opt < 1 || opt > 5
        opt = input('Invalid option. Select choice: ');
    end

    
    switch opt
        case 1
            display_movies(id, reviews, genres, cbf_1, seeds_1);
        
        case 5
            break;

        case default
            disp('Invalid option');
    end

    disp(' ')
end
