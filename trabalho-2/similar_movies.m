function set = similar_movies(id, reviews, min_hash, j_dist)
    Nh = length(min_hash(1,:));
    movies_id = [];
    % Get player movies w/ranking >= 3
    for movie=1:length(reviews{id})
        ranking = reviews{id}(movie,2);
        
        if ranking >= 3
            movie = reviews{id}(movie,1);
            movies_id(end+1) = movie;
        end
    end

    % For each movie, get all similar movies
    % with jaccard distance < j_dist
    similar_movies = [];
    cnt = 1;
    for movie1=movies_id
        for j=1:length(reviews{id}(:,1))
            movie2 = reviews{id}(j,1);
            if movie1 ~= movie2
                distance = 1 - (sum(min_hash(movie1,:)==min_hash(movie2,:))/Nh);
                if distance < j_dist
                    similar_movies(end+1) = movie2;
                end
            end
        end
        set{cnt} = [movie1 similar_movies];
        cnt = cnt + 1;
    end

end

