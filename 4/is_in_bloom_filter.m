function bool = is_in_bloom_filter(bloom_filter, seeds, k, element)
% Check if element is in bloom filter

bool = true;
N = length(bloom_filter);

% Generate k hashes using element
for i=1:length(seeds)
    hash = DJB31MA(element, seeds(i));

    % From hash, create index to check in bloom filter
    index = abs(mod(hash, N))+1;
    if bloom_filter(index) ~= 1
        bool = false;
        return
    end
end

end

