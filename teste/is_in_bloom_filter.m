function bool = is_in_bloom_filter(bloom_filter, k, element)
% Check if element is in bloom filter

bool = true;
N = length(bloom_filter);

% Generate k hashes using element
for i=1:k
    hash = string2hash([element num2str(i)]);

    % From hash, create index to check in bloom filter
    index = abs(mod(hash, N))+1;
    if bloom_filter(index) ~= 1
        bool = false;
        return
    end
end

end

