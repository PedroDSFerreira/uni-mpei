clc
clear all
close all

%-----RUN INIT.M FILE FIRST!-----
load 'vars.mat'
load 'bf_1.mat'
load 'bf_2.mat'
load 'min_hash_3.m'


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
        case 2
            % Get users with similar tastes (movies ranked>=3)
            users = similar_users(id, );
            % Get unseen movies from similar users
            movies = get_users_suggestions(id, users, reviews, genres);
            display_suggestions(movies)
        case 3
            % For each movie already evaluated by the user, get similar unseen movies based on genres
            movies_set = similar_movies(id, reviews, genres);
            % Get the two most common movies from the set
            movies = most_common_movies(id, movies_set, reviews, genres);
            display_suggestions(movies)
        case 4
            title = input('Insert movie title: ', 's');
            % Get movies with similar titles
            movies = similar_titles(title);
            display_suggestions(movies)
        case 5
            break;

        case default
            disp('Invalid option');
    end

    disp(' ')
end
