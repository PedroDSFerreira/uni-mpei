clc
clear all
close all

% --------------INITIALIZATION--------------

genres = readcell('u_item.txt', 'Delimiter', '\t');
[reviews, users, Nu] = get_users_info();


% Create counting bloom filter 1 (evaluated movies)
m_1 = length(reviews);
n_1 = m_1 * 8;
k_1 = round(n_1*log(2)/m_1);

seeds_1 = randi(2^32, k_1);

cbf_1 = init_bloom_filter(n_1);


% Create counting bloom filter 2 (evaluated movies w/ranking>=3)
m_2 = length(reviews);
n_2 = m_2 * 8;
k_2 = round(n_2*log(2)/m_2);

seeds_2 = randi(2^32, k_2);

cbf_2 = init_bloom_filter(n_2);


% insert movie titles of all users in bloom filter
for i = 1:Nu
    for j = 1:length(reviews{i,1})
        mov_title = genres{reviews{i,1}(j), 1};
        ranking = reviews{i,1}(j,2);

        cbf_1 = insert_bloom_filter(cbf_1, seeds_1, k_1, convertStringsToChars(mov_title));
        
        if ranking >= 3
            cbf_2 = insert_bloom_filter(cbf_2, seeds_2, k_2, convertStringsToChars(mov_title));
        end
    end
end






save 'vars.mat' 'users' 'Nu' 'reviews' 'genres' 'cbf_1' 'cbf_2' 'seeds_1' 'seeds_2'