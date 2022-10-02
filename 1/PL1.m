clear all
clc
close all
%% Código 1
% Gerar uma matriz com 3 linhas e 10000 colunas de n ́umeros aleat ́orios
% entre 0.0 e 1.0 (ou seja, cada coluna representa uma experiˆencia):
experiencias = rand(3,10000);
% Gerar uma matriz com 3 linhas e 10000 colunas com o valor 1 se o valor
% da matriz anterior for superior a 0.5 (ou seja, se saiu cara) ou com o
% valor 0 caso contr ́ario (ou seja, saiu coroa):
lancamentos = experiencias > 0.5; % 0.5 corresponde a 1 - prob. de caras
% Gerar um vetor linha com 10000 elementos com a soma dos valores de cada
% coluna da matriz anterior (ou seja, o n ́umero de caras de cada experiˆencia):
resultados= sum(lancamentos);
% Gerar um vetor linha com 10000 elementos com o valor 1 quando o valor do
% vetor anterior  ́e 2 (ou seja, se a experiˆencia deu 2 caras) ou 0 quando  ́e
% diferente de 2:
sucessos= resultados==2;
% Determinar o resultado final dividindo o n ́umero de experiˆencias com 2
% caras pelo n ́umero total de experiˆencias:
probSimulacao= sum(sucessos)/10000

%% Código 1 - segunda versão
N= 1e5; %numero de experiencias
p = 0.5; %probabilidade de cara
k = 2; %numero de caras
n = 3; %numero de lancamentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacao= sum(sucessos)/N

%% Ex. 2
N= 1e5; %numero de experiencias
p = 0.5; %probabilidade de cara
k = 6; %numero de caras
n = 15; %numero de lancamentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)==k;
probSimulacao= sum(sucessos)/N

%% Ex. 3
N= 1e5; %numero de experiencias
p = 0.5; %probabilidade de cara
k = 6; %numero de caras
n = 15; %numero de lancamentos
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos)>=k;
probSimulacao = sum(sucessos)/N

%% Ex. 4.a
N= 1e5; %numero de experiencias
p = 0.5; %probabilidade de cara
n = 15; %numero de lancamentos
for i=[20 40 100]
    prob = size(i);
    for k=0:i
        prob(k+1) = coin_toss_probability(p,n,k,N);
    end
    figure()
    
    stem(0:i,prob)
    str = sprintf('Número de lançamentos: %d', i);
    title(str);
end

%% Ex. 5
% Codigo 2- ca´lculo analı´tico de probabilidade em se´ries experieˆncias de Bernoulli
% Dados relativos ao problema 1
k = 2;
n = 3;
sample_size = 100;
for p=0:sample_size
    prob(p+1)= nchoosek(n,k)*p^k*(1-p)^(n-k); % nchoosek(n,k)= n!/(n-k)!/k!
end

plot(0:1/sample_size:1,prob)

%% Ex. 6.1
p = 0.3;
k = 3;
n = 5;
prob= nchoosek(n,k)*p^k*(1-p)^(n-k)

%% Ex. 6.2
p = 0.3;
k = 2;
n = 5;
prob= nchoosek(n,k)*p^k*(1-p)^(n-k)

%% Ex. 6.3 (not 100% sure)
p = 0.3;
n = 5;
for k=0:5
    prob(k+1) = nchoosek(n,k)*p^k*(1-p)^(n-k);
end
histogram(prob)