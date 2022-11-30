clc
clear all
close all

%% Ex. 1

function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector));
    state= states(i);
end

function keys = hashString(i_min, i_max, N, alphabet, arphabet_prob)
    if nargin < 5
        arphabet_prob = ones(1, length(alphabet)) / length(alphabet);
    end
    for i=1:N
        str = "";
        for j=1:round(randi([i_min, i_max]))
            str = strcat(str, discrete_rnd(alphabet, arphabet_prob));
        end
        keys{i} = str;
        
    end
end
