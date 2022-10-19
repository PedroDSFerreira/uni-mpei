clc
clear all
close all

% Parte I
% Ex.1

%% a)


S = 2;
sample_size = 1e4;
p = 0.5;
k = 1;
sons = rand(S, sample_size) >= p;
success = sum(sons) >= k;
'a)'
sum(success)/sample_size

%% b)
'b)'
(2+1)/4

%% c)
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

% Ex. 2
%% a)
n = 20;
m = 100;

sample_size = 1e4;
count = 0;
for sample = randi(m, n, sample_size)
    if length(unique(sample)) == n
        count = count + 1;
    end
end
p = count/sample_size

%% b)
n = 20;
m = 100;

sample_size = 1e4;

count = 0;
for sample = randi(m, n, sample_size)
    if length(unique(sample)) < n-1
        count = count + 1;
    end
end
p = count/sample_size

%% c)


sample_size = 1e5;


probability = zeros(1,10);
n = 10:10:100;
m = [1000 100000];
for i = 1:2
    for j = 1:10
        count = 0;
        for sample = randi(m(i), n(j), sample_size)
            if length(unique(sample)) < n(j)-1
                count = count + 1;
            end
        end
        probability(j) = count/sample_size;
    end

    subplot(2,1,i);
    plot(n,probability);
    legend(strcat('m=', num2str(m(i))));
    xlabel('m');
    ylabel('Probability');
end

%% d)

m = [200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000];
n = 100;

sample_size = 1e5;
for i = 1:length(m)
    count = 0;
    for sample = randi(m(i), n, sample_size)
        if length(unique(sample)) < n-1
            count = count + 1;
        end
    end
    p(i) = count/sample_size;
end

plot(m, p, '-.')
legend(strcat('n=', num2str(n)));
xlabel('m');
ylabel('Probability');


% Ex. 3
%% a)
k = 10; % number of keys
T = 1000; % array size

sample_size = 1e6;

count = 0;
for sample = randi(T, k, sample_size)
    if length(unique(sample)) < k-1
        count = count + 1;
    end
end
p = count/sample_size

%% b)
k = 10:100:1000; % number of keys
T = 1000; % array size
sample_size = 1e4;

for i = 1:length(k)
    count = 0;
    for sample = randi(T, k(i), sample_size)
        if length(unique(sample)) < k(i)-1
            count = count + 1;
        end
    end
    p(i) = count/sample_size;
end

plot(k, p, '-.')
legend(strcat('T=', num2str(T)));
xlabel('Keys');
ylabel('Probability');

%% c)
k = 50; % number of keys
T = 100:100:1000; % array size
sample_size = 1e4;

for i = 1:length(T)
    count = 0;
    for sample = randi(T(i), k, sample_size)
        if length(unique(sample)) == k
            count = count + 1;
        end
    end
    p(i) = count/sample_size;
end

plot(T, p, '-.')
legend(strcat('k=', num2str(k)));
xlabel('T');
ylabel('Probability');


% Ex. 4 - TODO
%% a)
p = 0.5;
d = 365; % days
sample_size = 1e4;


% Ex. 7
%% a)
% Teórica

% P(ser do Carlos | tem um bug) = P(ser do Carlos n tem um bug)/P(tem um
% bug) ?


% P(ser do Carlos n tem um bug) = P(tem um bug | ser do Carlos) * P(ser do
% Carlos)
pCbug = 0.001*0.5;

% P(tem um bug) = P(tem um bug | ser do Carlos)+P(tem um bug | ser do
% André)+P(tem um bug | ser do Bruno)
pbug = 0.01*0.2 + 0.05*0.3 + 0.001*0.5;

% P(ser do Carlos | tem um bug) = P(ser do Carlos n tem um bug)/P(tem um
% bug)
probC = pCbug/pbug


% b)
pAbug = 0.01*0.2;
probA = pAbug/pbug

pBbug = 0.05*0.3;
probB = pBbug/pbug


% Parte II
% Ex. 2
