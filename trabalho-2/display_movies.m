function display_movies(id, set, dic, bf, seeds)
% If the option is 1, the program will show the movies that the user has
% already evaluated
disp('Your movies:');
for i = 1:length(set{id, 1})
    movie = dic{set{id,1}(i),1};
    % Get count from Bloom Filter
    count = count_bloom_filter(bf, seeds, movie);
    disp(['- ', movie, ': ', num2str(count)]);
end

