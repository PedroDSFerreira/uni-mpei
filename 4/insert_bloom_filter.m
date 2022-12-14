function bloom_filter = insert_bloom_filter(bloom_filter, seeds, k, element)
% Insert element in bloom filter

assert(length(seeds)==k);

N = length(bloom_filter);

% Generate k hashes using element
for i=1:k
    hash = DJB31MA(element, seeds(i));
    
    % From hash, create index to store in bloom filter
    index = abs(mod(hash, N))+1;
    bloom_filter(index) = 1;
end


end

