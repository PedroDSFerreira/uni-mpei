function movies = get_users_suggestions(id, users, reviews, genres)
% Get the list of movies reviewed by users and not seen by the user


self_reviews = reviews{id}(:,1);
movies_id = [];
for i = 1:length(users)
    movies_id = [movies_id; setdiff(reviews{i}(:,1), self_reviews)];
end
movies_id = unique(movies_id);

% Get movie names
for i = 1:length(movies_id)
    movies(i) = convertCharsToStrings(genres{movies_id(i)});
end
end

