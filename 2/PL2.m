clc
clear all
close all

% Parte I
%% Ex.1 - a)


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


%% Ex. 2 - a)
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

%% Ex. 3 - a)
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

%% Ex. 4 - a) - TODO
p = 0.5;
d = 365; % days
sample_size = 1e4;

%% Ex. 7 - a)
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
%% Ex. 1 - a)
pX = ones(1,6)/6;
xi = 1:6;

stem(xi, pX);
ylabel('pX');
xlabel('xi');

%% b)
FX = cumsum([0 0 pX 0 0]);
stairs(-1:8, FX);
  
%% Ex. 2 - a)
x = 1:100;
px = ones(1,100)/100;
subplot (2, 1, 1);
stem(x, px), xlabel('x'), ylabel('P(x)');

%% b)
xi = [5 50 100];
cFav = [90 9 1];
Px = cFav/100;

%% c)
subplot (2, 1, 2);
Fx = cumsum([0 0 pNota 0 0]);
stairs(-1:102, Fx);

%% Ex. 4 (REALIZADO EM GRUPO)
N = 1e5;
p = 0.3;
n = 5; % num de peças

xi = 0:5;
pX = zeros(1,5);
amostras = rand(n,N) <= p;

for k=0:5
    sucesso = sum(amostras)==k;
    pX(k+1) = sum(sucesso)/N;
end

FX = cumsum([0 pX 0]);
stairs(-1:6, FX);

Prob = sum(sum(amostras)<=2)/N;

%% Ex. 6 - a) (REALIZADO EM GRUPO)
p = 1/1000; % probabilidade
n = 8000; % espaço de amostragem - chips
k = 7; % defeitos
% E[x] = n*p = 8

% Poisson
lambda=n*p;
pX1 = ((lambda^k)/factorial(k))*(exp(-lambda));

%% b) (REALIZADO EM GRUPO)
% Binomial
% pX2 = factorial(n)/(factorial(n-k)*factorial(k)*p^k*(1-p)^(n-k));
pX2 = prod(n:-1:n-k+1)/prod(1:k)*p^k*(1-p)^(n-k);

%% Ex. 7 - a) (REALIZADO EM GRUPO)
n = 1;
p = 15;
k = 0;
lambda = p * n;
pk = lambda^k * exp(-lambda) / factorial(k);

%% b) (REALIZADO EM GRUPO)
n = 1;
p = 15;
k = 10;
lambda = p * n;
x = 0;

for i = 0 : k
    x = x + lambda^i * exp(-lambda) / factorial(i);
end
p = 1-x

%% Ex. 8
lambda = 0.02; n = 100;

lambda = lambda * n;
pk = 0;

for k = 0 : 1
    pk = pk + lambda^k * exp(-lambda) / factorial(k);
end

pk