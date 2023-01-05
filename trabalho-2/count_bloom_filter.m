function count = count_bloom_filter(bloom_filter, seeds, element)
% Check if element is in bloom filter

tmp = 1:length(seeds);
j = 0;
N = length(bloom_filter);

% Generate k hashes using element
for i=1:length(seeds)
    hash = DJB31MA(element, seeds(i));

    % From hash, create index to check in bloom filter
    index = abs(mod(hash, N))+1;
    if bloom_filter(index) == 0
        count = 0;
        return
    end
    
    j = j + 1;
    tmp(j) = bloom_filter(index);
end

count = min(tmp);

end

