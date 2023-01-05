clc
clear all
close all

% Initialization

genres = readcell('u_item.txt', 'Delimiter', '\t');
[reviews, users, Nu] = get_users_info();

% Create counting bloom filter (evaluated movies)
m = length(reviews);
n = m * 8;
k = round(n*log(2)/m);
seeds = randi(2^32, k);

cbf = init_bloom_filter(n);

% insert movie titles of all users in bloom filter
for i = 1:Nu
    for j = 1:length(reviews{i,1})
        mov_title = genres{reviews{i,1}(j), 1};
        cbf = insert_bloom_filter(cbf, seeds, k, convertStringsToChars(mov_title));
    end
end



save 'vars.mat' 'users' 'Nu' 'reviews' 'genres' 'cbf' 'seeds'