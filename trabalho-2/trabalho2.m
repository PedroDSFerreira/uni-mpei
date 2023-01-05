clc
clear all
close all

% Initialization
dic = readcell('u_item.txt', 'Delimiter', '\t');
set = get_users_info();

% Create counting bloom filter
m = length(set);
n = m * 8;
k = round(n*log(2)/m);
seeds = randi(2^32, k);

cbf = init_bloom_filter(n);

for i = 1:length(set)
    for j = 1:length(set{i,1})
        cbf = insert_bloom_filter(cbf, seeds, k, convertStringsToChars(dic{set{i,1}(j), 1}));
    end
end


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
            display_movies(id, set, dic, cbf, seeds);

        case 5
            break;

        case default
            disp('Invalid option');
    end

    disp(' ')
end
