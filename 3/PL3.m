clc
clear all
close all

%% Ex. 1 - a)
% valor estacionário:
% v*A = v

% matriz de transição
A = [
    0.7, 0.3; 
    0.8, 0.2
    ];

% vetor estacionário ([está presente, não está presente])
v = [1, 0];

prob = v*A;
prob(1)

%% b)

% matriz de transição
A = [
    0.7, 0.3; 
    0.8, 0.2
    ];

% vetor estacionário ([está presente, não está presente])
v = [0, 1];

prob = v*A;
prob(1)

%% c)

% matriz de transição
A = [
    0.7, 0.3; 
    0.8, 0.2
    ];

sample_size = 1e4;
weeks = 15;
results = zeros(1, sample_size);

for j=1:sample_size
    v = [1, 0];
    for week=1:weeks
        v = v*A;
    end
    results(j) = v(1);
end
mean(results)

%% d) TODO

