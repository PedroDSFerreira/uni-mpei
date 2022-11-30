clc
clear all
close all

%% Ex. 1

% a)
N = 1e6;
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

keyGen(i_min, i_max, N, alphabet)

% b)
N = 1e6;
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

alphabet_prob = load("4/prob_pt.txt")'

keyGen(i_min, i_max, N, alphabet, alphabet_prob)




function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector));
    state= states(i);
end

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