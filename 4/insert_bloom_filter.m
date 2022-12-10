function bloom_filter = insert_bloom_filter(bloom_filter, seeds, k, element)
% Insert element in bloom filter

assert(length(seeds)==k);

N = length(bloom_filter);

% Generate k hashes using element
hashes = zeros(1, k);
for i=1:k
    hashes(i) = DJB31MA(element, seeds(i));
    
    % From hash, create index to store in bloom filter
    index = abs(mod(hashes(i), N))+1;
    bloom_filter(index) = 1;
end


end

