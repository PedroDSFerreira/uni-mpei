function movies = similar_titles(title, genres, min_hash, s_size, seeds, k)
    % Split movie title into shingles
    Nm = length(min_hash);
    Ns = length(title)-s_size+1;

    hashes = zeros(1, k);
    hash_codes = inf(Ns, k);
    % Get hash codes of shingles
    for i = 1:Ns
        shingle = (i:i+s_size-1);
        
        % calculate hash of each shingle
        for h = 1:k
            hash_codes(i, h) = DJB31MA([shingle, h], seeds(h));
        end
    end

    hashes = min(hash_codes);

    % Compare hash codes with min_hash matrix
    jaccard = zeros(1, Nm);

    for i = 1:Nm
        jaccard(1,i) = sum(hashes==min_hash(i,:));
    end

    % Sort in ascending order
    [~, idx] = sort(jaccard, 'ascend');

    % Get top 5 movies
    movies_id = idx(1:5);
    if length(movies_id) ~= 0
        % Get movie titles
        for i = 1:length(movies_id)
            movies(i) = convertCharsToStrings(genres{movies_id(i)});
        end
    else
        movies = [];
end

