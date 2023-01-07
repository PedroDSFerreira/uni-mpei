function movies = most_reviewed_movies(movies_set, genres)
% Find the most reviewed movies in a set of movies

% Count the number of reviews for each movie in the set
movie_counter = [];
for i = 1:length(movies_set)
    for j = 2:length(movies_set{i})
        if ~ismember(movies_set{i}(j), movie_counter)
            movie_counter(end+1,:) = [movies_set{i}(j), 1];
        else
            index = movie_counter(:,1) == movies_set{i}(j);
            movie_counter(index, 2) = movie_counter(index, 2) + 1;
        end
    end
end
% Sort the movies by the number of reviews
movie_counter = sortrows(movie_counter, -2);

% Get the name of the top 2 movies
movies(1) = convertCharsToStrings(genres{movie_counter(1,1)});
movies(2) = convertCharsToStrings(genres{movie_counter(2,1)});

end