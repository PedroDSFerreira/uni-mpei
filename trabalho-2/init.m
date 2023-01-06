clc
clear all
close all

% --------------INITIALIZATION--------------

genres = readcell('u_item.txt', 'Delimiter', '\t');
[reviews, users, Nu] = get_users_info();

% Number of movies
Nm = length(genres);


% Create counting bloom filter 1 (evaluated movies)
m_1 = Nu;
n_1 = m_1 * 8;
k_1 = round(n_1*log(2)/m_1);

seeds_1 = randi(2^32, k_1);

cbf_1 = init_bloom_filter(n_1);


% Create counting bloom filter 2 (evaluated movies w/ranking>=3)
m_2 = Nu;
n_2 = m_2 * 8;
k_2 = round(n_2*log(2)/m_2);

seeds_2 = randi(2^32, k_2);

cbf_2 = init_bloom_filter(n_2);


% insert movie titles of all users in bloom filter
for i = 1:Nu
    for j = 1:length(reviews{i})
        mov_title = convertStringsToChars(genres{reviews{i}(j), 1});
        ranking = reviews{i}(j,2);

        cbf_1 = insert_bloom_filter(cbf_1, seeds_1, k_1, mov_title);
        
        if ranking >= 3
            cbf_2 = insert_bloom_filter(cbf_2, seeds_2, k_2, mov_title);
        end
    end
end




k_3 = 100;
seeds_3 = randi(2^32, k_3);
min_hash_3 = zeros(Nu,k_3);

for usr = 1:Nu
    hash_codes = inf(Nm, k_3);
    for h = 1:k_3
        for movie = 1:length(reviews{usr})
            mov_title = convertStringsToChars(genres{reviews{usr}(movie), 1});
            ranking = reviews{usr}(movie,2);

            if ranking >= 3
                hash_codes(movie, h) = DJB31MA(mov_title,seeds_3(h));
            end
        end

    end

    min_hash_3(usr, :) = min(hash_codes);
end


save 'vars.mat' 'users' 'Nu' 'reviews' 'genres'
save 'bf_1.mat' 'cbf_1' 'seeds_1'
save 'bf_2.mat' 'cbf_2' 'seeds_2'
save 'min_hash.mat' 'min_hash_3'