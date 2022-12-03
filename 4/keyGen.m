function keys = keyGen(i_min, i_max, N, alphabet, arphabet_prob)
    if nargin < 5
        arphabet_prob = ones(1, length(alphabet)) / length(alphabet);
    end
    for i=1:N
        str = [];
        for j=1:round(randi([i_min, i_max]))
            str(j) = discrete_rnd(alphabet, arphabet_prob);
        end
        keys{i} = strcat(str);
        
    end
end