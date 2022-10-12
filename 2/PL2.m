clc
clear all
close all

% Parte I
%% Ex.1

% a)


S = 2;
sample_size = 1e4;
p = 0.5;
k = 1;
sons = rand(S, sample_size) >= p;
success = sum(sons) >= k;
'a)'
sum(success)/sample_size

% b)
'b)'
(2+1)/4

% c)
'c)'
% P(A|B) = P(AnB)/P(B)

% Valor Prático:
sample_size = 1e4;
S = 2;
p = 0.5;

sample = rand(S, sample_size) >= p;

k = 1;

b = sum(sample) >= k;
p_b = sum(b)/sample_size;

k = 2;
ab = sum(sample) == k;
p_ab = sum(ab)/sample_size;

'Valor Prático'
p_ab/p_b

% Valor Teórico:
'Valor Teórico'
1/(2+1)

%% Ex. 2
%% a)
n = 20;
m = 100;

sample_size = 1e4;

for samples = 1:sample_size-1
    count = 0;
    for sample = round(rand(n, m)* 100)
        if length(unique(sample)) == n
            count = count + 1;
        end  
    end
    probs(samples) = count/n;
end
p = sum(probs)/sample_size

%% b)
n = 20;
m = 100;

sample_size = 1e4;
count = 0;
for samples = 1:sample_size-1
    for sample = round(rand(n, m)* 100)
        if length(unique(sample)) <= n-2
            count = count + 1;
            break
        end  
    end
end
p = count/sample_size