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
