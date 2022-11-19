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

% vetor ([está presente, não está presente])
v = [1, 0];

prob = v*A^2;
prob(1)

%% b)

% matriz de transição
A = [
    0.7, 0.3; 
    0.8, 0.2
    ];

% vetor ([está presente, não está presente])
v = [0, 1];

prob = v*A^2;
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
    for week=1:weeks*2-1
        v = v*A;
    end
    results(j) = v(1);
end
mean(results)

%% d)

% matriz de transição
A = [
    0.7, 0.3; 
    0.8, 0.2
    ];

classes = 30;
results = zeros(1, classes);
v = [0.85, 0.15];

for class=1:classes
    results(class) = v(2);
    v = v*A;
end

stem(results)

%% Ex. 2 - a)


% matriz de transição
A = [
    1/3 1/4 0;
    1/3 11/20 1/2;
    1/3 1/5 1/2
];

% matriz é estocástica (soma das colunas==1)

%% b)

alunos = 90;

v = [alunos/2; alunos/4; alunos/4];

%% c)

% matriz de transição
A = [
    1/3 1/4 0;
    1/3 11/20 1/2;
    1/3 1/5 1/2
];

alunos = 90;

v = [alunos/2; alunos/4; alunos/4];

for i=1:30-1
    v = A*v;
end

round(v)

%% d)

% matriz de transição
A = [
    1/3 1/4 0;
    1/3 11/20 1/2;
    1/3 1/5 1/2
];

alunos = 90;

v = [alunos/3; alunos/3; alunos/3];

for i=1:30-1
    v = A*v;
end

round(v)

%% Ex. 3 - a)

A = rand(20);
A = A./sum(A);
% matriz não estocástica

%% b)

A = rand(20);
A = A./sum(A);
v = zeros(20, 1);
v(1) = 1;
probs = zeros(20, 100);
probs(:,1) = v(1);
for i=2:100
    v = A*v;
    probs(:,i) = v;
end

fprintf("2: %.5f\n", probs(20,2))
fprintf("5: %.5f\n", probs(20,5))
fprintf("10: %.5f\n", probs(20,10))
fprintf("100: %.5f\n", probs(20,100))

%% Ex. 4 - a)
p = 0.4;
q = 0.6;

A = [
    p^2 0 0 q^2;
    (1-p)^2 0 0 q*(1-q);
    p*(1-p) 0 0 q*(1-q);
    p*(1-p) 1 1 (1-q)^2
];

%% b)

p = 0.4;
q = 0.6;

A = [
    p^2 0 0 q^2;
    (1-p)^2 0 0 q*(1-q);
    p*(1-p) 0 0 q*(1-q);
    p*(1-p) 1 1 (1-q)^2
];

v = [1; 0; 0; 0];
probs = zeros(4, 200);
probs(:,1) = v(1);
for i=2:200
    v = A*v;
    probs(:,i) = v;
end

probs(:,5)
probs(:,10)
probs(:,100)
probs(:,200)

%% c)

p = 0.4;
q = 0.6;

A = [
    p^2 0 0 q^2;
    (1-p)^2 0 0 q*(1-q);
    p*(1-p) 0 0 q*(1-q);
    p*(1-p) 1 1 (1-q)^2
];

v = [1; 0; 0; 0];

% iterative method (not recomended)
i = 2;
while true
    v_temp = A*v;
    if v_temp == v
        v = v_temp;
        break
    end
    v = v_temp;
    i = i+1;
end

v

% algebraic method 1 (recomended)

M= [A-eye(length(A));ones(1,length(A))];
x= zeros(length(A) ,1);
x= [x; 1];

M\x

% algebraic method 2 (recomended)
M= [A-eye(length(A));ones(1,length(A))];
x= zeros(length(A) ,1);
x= [x; 1];
sol = rref([M x]);
sol(1:length(A), end)

%% Ex. 5 - a)
% Matriz não estocátsica
A = [
    .7 .2 .1;
    .2 .3 .5;
    .3 .3 .4;
];

%% b)
% P(sol->sol)*P(sol->sol)
A = [
    .7 .2 .1;
    .2 .3 .5;
    .3 .3 .4;
];
A= A';
v = [1; 0; 0];

prob = A*v;
prob(1)^2

%% c)
% P(sol->Ñ chuva)*P(Ñ chuva->Ñ chuva)

%CB: está a usar a notação errada, em MPEI usamos Xn nas colunas e Xn+1 nas
%linhas. A soma das colunas tem de dar 1 em todas as  colunas
 
A = [
    .7 .2 .1;
    .2 .3 .5;
    .3 .3 .4;
];
% CB: transpondo a matriz fica na notação correta
A= A';
% sum(A)  % CB: verifique que a soma das colunas é 1 para todas as colunas

v0 = [1; 0; 0];

% P(sol->Ñ chuva)
v1 = A*v0; %CB: daqui obtém a probabilidade da 1ª transição

prob1= sum(v1(1:2));  %CB: vai necessitar desta probabilidade mais tarde

v1(3)= 0; % CB: alterar a probabilide de chuva para zero (somatório fica < 1)
v1 = v1/sum(v1(1:2)); % normalize
% CB: pode verificar agora que a soma de probabilidades de v1 é 1 e que a
% probabilidade de chuva é zero



% P(Ñ chuva->Ñ chuva)
v2 = A*v1;
%CB: aqui já não faz sentido normalizar v2 = v2/(v2(1)+v2(2)); % normalize
prob2= sum(v2(1:2));  %CB: cálculo da probabilidade de transição de Ñ chuva->Ñ chuva
resultado= prob1 * prob2; % CB

%CB: apresentação do resultdo
fprintf('Probabilidade de não chover no 2º e 3º dias dado que no dia 1 está sol = %4.3f\n', resultado)

%% d)
A = [
    .7 .2 .1;
    .2 .3 .5;
    .3 .3 .4;
];

A= A';

v = [1; 0; 0];% 1º dia -> sol

% Janeiro -> 31 dias
v = A^30*v;

sol = round(v(1)*31)
nuvens = round(v(2)*31)
chuva = round(v(3)*31)

%% e)
A = [
    .7 .2 .1;
    .2 .3 .5;
    .3 .3 .4;
];

A= A';

v = [0; 0; 1]; % 1º dia -> chuva

% Janeiro -> 31 dias
v = A^30*v;

days = round(v*31);

sol = days(1)
nuvens = days(2)
chuva = days(3)

%% f)
A = [
    .7 .2 .1;
    .2 .3 .5;
    .3 .3 .4;
];

A= A';


p = [.1; .3; .5];

% 1º dia -> chuva
v = [0; 0; 1];

% Janeiro -> 31 dias
v = A^30*v;


days = (v*31).*p;

rheumatism_days = round(sum(days))

%% Ex. 6 - a)
    
A = [
    .8 0 0 .3 0;
    .2 .6 0 .2 0;
    0 .3 1 0 0;
    0 .1 0 .4 0;
    0 0 0 .1 1
    ];

%% b)
A = [
    .8 0 0 .3 0;
    .2 .6 0 .2 0;
    0 .3 1 0 0;
    0 .1 0 .4 0;
    0 0 0 .1 1
    ];

v = [1; 0; 0; 0; 0];

% P(1->2)
probs = [];

for n = 1:100
    v_tmp = (A^(n))*v;
    probs(n) = v_tmp(2);
end

stem(probs)
% with n->+inf, lim(probability)=0

%% c)
A = [
    .8 0 0 .3 0;
    .2 .6 0 .2 0;
    0 .3 1 0 0;
    0 .1 0 .4 0;
    0 0 0 .1 1
    ];

v = [1; 0; 0; 0; 0];

% P(1->3)
probs = [];

for n = 1:100
    v_tmp = (A^(n))*v;
    probs(n) = v_tmp(3);
end

hold on
stem(probs)



% P(1->5)
probs = [];

for n = 1:100
    v_tmp = (A^(n))*v;
    probs(n) = v_tmp(5);
end

stem(probs)
legend('P(1->3)', 'P(1->5)')

% with n->+inf, lim(probability)=x

%% d)
Q = [
    .8 0 .3;
    .2 .6 .2;
    0 .1 .4;
    ];
%% e)
Q = [
    .8 0 .3;
    .2 .6 .2;
    0 .1 .4;
    ];
F = (ones(3)-Q)^(-1)