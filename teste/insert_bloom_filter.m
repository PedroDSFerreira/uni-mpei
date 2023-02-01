function bloom_filter = insert_bloom_filter(bloom_filter, k, element)
% Insert element in bloom filter

N = length(bloom_filter);

% Generate k hashes using element
for i=1:k
    hash = string2hash(element);
    
    % From hash, create index to store in bloom filter
    index = abs(mod(hash, N))+1;
    bloom_filter(index) = 1;
end


end

