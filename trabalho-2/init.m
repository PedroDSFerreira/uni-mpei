clc
clear all
close all

% --------------INITIALIZATION--------------

genres = readcell('u_item.txt', 'Delimiter', '\t');
[reviews, users, Nu] = get_users_info();

% Number of movies
[Nm, Ng] = size(genres);
Ng = Ng-1;


% Create counting bloom filter 1 (evaluated movies)
m_1 = Nu;
n_1 = m_1 * 8;
k_1 = round(n_1*log(2)/m_1);

seeds_1 = randi(2^32, k_1);

cbf_1 = init_bloom_filter(n_1);


% insert movie titles of all users in bloom filter
for i = 1:Nu
    for j = 1:length(reviews{i})
        mov_title = convertStringsToChars(genres{reviews{i}(j), 1});
        ranking = reviews{i}(j,2);

        cbf_1 = insert_bloom_filter(cbf_1, seeds_1, k_1, mov_title);
    end
end




k_2 = 100;
seeds_2 = randi(2^32, k_2);
min_hash_2 = zeros(Nu,k_2);

for usr = 1:Nu
    hash_codes = inf(Nm, k_2);
    for h = 1:k_2
        for movie = 1:length(reviews{usr})
            mov_title = convertStringsToChars(genres{reviews{usr}(movie), 1});
            ranking = reviews{usr}(movie,2);

            if ranking >= 3
                hash_codes(movie, h) = DJB31MA(mov_title,seeds_2(h));
            end
        end

    end

    min_hash_2(usr, :) = min(hash_codes);
end


k_3 = 1000;
seeds_3 = randi(2^32, k_3);
min_hash_3 = zeros(Nm,k_3);
genres_names = ["unknown" "Action" "Adventure" "Animation" "Childrens" "Comedy" ...
    "Crime" "Documentary" "Drama" "Fantasy" "Film-Noir" "Horror" "Musical" ...
    "Mistery" "Romance" "Sci-Fi" "Thriller" "War" "Western"];
for movie = 1:Nm
    hash_codes = inf(Ng, k_3);
    for genre = 1:Ng-1
        if genres{movie, genre+1}
            genre_name = convertStringsToChars(genres_names(genre));
            for h = 1:k_3
                hash_codes(genre, h) = DJB31MA(genre_name,seeds_3(h));
            end
        end

    end

    min_hash_3(movie, :) = min(hash_codes);
end


k_4 = 100;
seeds_4 = randi(2^32, k_4);
s_size = 3;
min_hash_4 = zeros(Nm,k_4);

for i = 1:Nm
    movie = lower(genres{i});
    Ns = length(movie)-s_size+1;
    hash_codes = inf(Ns, k_4);

    shingles = {};
    for j = 1:Ns
        shingles{j} = movie(j:j+s_size-1);
        
        for h = 1:k_4
            hash_codes(j, h) = DJB31MA([shingles{j}, h], seeds_4(h));
        end
    end

    min_hash_4(i, :) = min(hash_codes);
end



save 'vars.mat' 'users' 'Nu' 'reviews' 'genres'
save 'bf_1.mat' 'cbf_1' 'seeds_1'
save 'min_hash_2.mat' 'min_hash_2'
save 'min_hash_3.mat' 'min_hash_3'
save 'min_hash_4.mat' 'min_hash_4' 's_size' 'seeds_4' 'k_4'