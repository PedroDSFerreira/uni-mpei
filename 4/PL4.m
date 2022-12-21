clc
clear all
close all

%% Parte I - Ex. 1

%% a)
N = 1e5;
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

keyGen(i_min, i_max, N, alphabet)

%% b)
N = 1e5;
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

alphabet_prob = load("prob_pt.txt")';

keyGen(i_min, i_max, N, alphabet, alphabet_prob)

%% Ex. 2

N = 1e5;
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

keys = keyGen(i_min, i_max, N, alphabet);

% hash table sizes
table_sizes = [5e5 1e6 2e6];


simulation_1 = cell(3);
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = string2hash(keys{j}, 'djb2');
        index = abs(mod(hashcode, table_sizes(i)))+1;

        indexes(j) = index;
    end
    simulation_1{i, 1} = indexes;
    simulation_1{i, 2} = length(indexes)-length(unique(indexes));
    simulation_1{i, 3} = toc;
end


simulation_2 = cell(3);
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = string2hash(keys{j}, 'sdbm');
        index = abs(mod(hashcode, table_sizes(i)))+1;
        
        indexes(j) = index;
    end
    simulation_2{i, 1} = indexes;
    simulation_2{i, 2} = length(indexes)-length(unique(indexes));
    simulation_2{i, 3} = toc;
end

simulation_3 = cell(3);
seed = 123;
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = DJB31MA(keys{j}, seed);
        index = abs(mod(hashcode, table_sizes(i)))+1;
        
        indexes(j) = index;
    end
    simulation_3{i, 1} = indexes;
    simulation_3{i, 2} = length(indexes)-length(unique(indexes));
    simulation_3{i, 3} = toc;
end

simulation_4 = cell(3);
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = hashstring(keys{j}, table_sizes(i));
        index = hashcode+1;
        
        indexes(j) = index;
    end
    simulation_4{i, 1} = indexes;
    simulation_4{i, 2} = length(indexes)-length(unique(indexes));
    simulation_4{i, 3} = toc;
end

%% Ex. 3
% a)
% i)
for i=1:3
    figure()
    subplot(4,1,1)
    histogram(simulation_1{i, 1}, 100)
    title('djb2')
    subplot(4,1,2)
    histogram(simulation_2{i, 1}, 100)
    title('sdbm')
    subplot(4,1,3)
    histogram(simulation_3{i, 1}, 100)
    title('DJB31MA')
    subplot(4,1,4)
    histogram(simulation_4{i, 1}, 100)
    title('hashstring')
end

% b)

figure()

hold on
plot(table_sizes, [simulation_1{1:end, 2}])
plot(table_sizes, [simulation_2{1:end, 2}])
plot(table_sizes, [simulation_3{1:end, 2}])
plot(table_sizes, [simulation_4{1:end, 2}])

title('Number of colisions')
legend('djb2', 'sdbm', 'DJB31MA', 'hashstring')


max_1 = zeros(1,3);
max_2 = zeros(1,3);
max_3 = zeros(1,3);
max_4 = zeros(1,3);

for i=1:3
    sim_1 = simulation_1{i, 1};
    sim_2 = simulation_2{i, 1};
    sim_3 = simulation_3{i, 1};
    sim_4 = simulation_4{i, 1};
    
    % count the number of times the mode appeared
    max_1(i) = sum(sim_1(:) == mode(sim_1));
    max_2(i) = sum(sim_2(:) == mode(sim_2));
    max_3(i) = sum(sim_3(:) == mode(sim_3));
    max_4(i) = sum(sim_4(:) == mode(sim_4));
end

figure()
hold on
plot(table_sizes, max_1)
plot(table_sizes, max_2)
plot(table_sizes, max_3)
plot(table_sizes, max_4)

title('Max number of times indexes were used')
legend('djb2', 'sdbm', 'DJB31MA', 'hashstring')

% c)

figure()

hold on
plot(table_sizes, [simulation_1{1:end, 3}])
plot(table_sizes, [simulation_2{1:end, 3}])
plot(table_sizes, [simulation_3{1:end, 3}])
plot(table_sizes, [simulation_4{1:end, 3}])

title('Execution time')
legend('djb2', 'sdbm', 'DJB31MA', 'hashstring')

%% 4
N = 1e5;
i_min = 6;
i_max = 20;
alphabet = 'a':'z';

alphabet_prob = load("prob_pt.txt")';

keys = keyGen(i_min, i_max, N, alphabet, alphabet_prob);

% hash table sizes
table_sizes = [5e5 1e6 2e6];


simulation_1 = cell(3);
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = string2hash(keys{j}, 'djb2');
        index = abs(mod(hashcode, table_sizes(i)))+1;

        indexes(j) = index;
    end
    simulation_1{i, 1} = indexes;
    simulation_1{i, 2} = length(indexes)-length(unique(indexes));
    simulation_1{i, 3} = toc;
end


simulation_2 = cell(3);
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = string2hash(keys{j}, 'sdbm');
        index = abs(mod(hashcode, table_sizes(i)))+1;
        
        indexes(j) = index;
    end
    simulation_2{i, 1} = indexes;
    simulation_2{i, 2} = length(indexes)-length(unique(indexes));
    simulation_2{i, 3} = toc;
end

simulation_3 = cell(3);
seed = 123;
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = DJB31MA(keys{j}, seed);
        index = abs(mod(hashcode, table_sizes(i)))+1;
        
        indexes(j) = index;
    end
    simulation_3{i, 1} = indexes;
    simulation_3{i, 2} = length(indexes)-length(unique(indexes));
    simulation_3{i, 3} = toc;
end

simulation_4 = cell(3);
for i=1:length(table_sizes)
    indexes = zeros(1, N);
    tic
    for j=1:N
        hashcode = hashstring(keys{j}, table_sizes(i));
        index = hashcode+1;
        
        indexes(j) = index;
    end
    simulation_4{i, 1} = indexes;
    simulation_4{i, 2} = length(indexes)-length(unique(indexes));
    simulation_4{i, 3} = toc;
end


for i=1:3
    figure()
    subplot(4,1,1)
    histogram(simulation_1{i, 1}, 100)
    title('djb2')
    subplot(4,1,2)
    histogram(simulation_2{i, 1}, 100)
    title('sdbm')
    subplot(4,1,3)
    histogram(simulation_3{i, 1}, 100)
    title('DJB31MA')
    subplot(4,1,4)
    histogram(simulation_4{i, 1}, 100)
    title('hashstring')
end


figure()

hold on
plot(table_sizes, [simulation_1{1:end, 2}])
plot(table_sizes, [simulation_2{1:end, 2}])
plot(table_sizes, [simulation_3{1:end, 2}])
plot(table_sizes, [simulation_4{1:end, 2}])

title('Number of colisions')
legend('djb2', 'sdbm', 'DJB31MA', 'hashstring')


max_1 = zeros(1,3);
max_2 = zeros(1,3);
max_3 = zeros(1,3);
max_4 = zeros(1,3);

for i=1:3
    sim_1 = simulation_1{i, 1};
    sim_2 = simulation_2{i, 1};
    sim_3 = simulation_3{i, 1};
    sim_4 = simulation_4{i, 1};
    
    % count the number of times the mode appeared
    max_1(i) = sum(sim_1(:) == mode(sim_1));
    max_2(i) = sum(sim_2(:) == mode(sim_2));
    max_3(i) = sum(sim_3(:) == mode(sim_3));
    max_4(i) = sum(sim_4(:) == mode(sim_4));
end

figure()
hold on
plot(table_sizes, max_1)
plot(table_sizes, max_2)
plot(table_sizes, max_3)
plot(table_sizes, max_4)

title('Max number of times indexes were used')
legend('djb2', 'sdbm', 'DJB31MA', 'hashstring')


figure()

hold on
plot(table_sizes, [simulation_1{1:end, 3}])
plot(table_sizes, [simulation_2{1:end, 3}])
plot(table_sizes, [simulation_3{1:end, 3}])
plot(table_sizes, [simulation_4{1:end, 3}])

title('Execution time')
legend('djb2', 'sdbm', 'DJB31MA', 'hashstring')

%% Parte II
% Ex. 1
n = 8000;
k = 3;
word_list = readlines("wordlist-preao-20201103.txt");
U1 = word_list(1:1000);

% Initialize Bloom Filter
bloom_filter = init_bloom_filter(n);

seeds = randi(2^32, k);
% Insert words in Bloom Filter
for i = 1:length(U1)
    bloom_filter = insert_bloom_filter(bloom_filter, seeds, k, convertStringsToChars(U1(i)));
end

% Ex. 2
% Test if the same words are in Bloom Filter
bools_b = zeros(1, length(U1));
for i = 1:length(U1)
    bools_b(i) = is_in_bloom_filter(bloom_filter, seeds, k, convertStringsToChars(U1(i)));
end
fprintf('\nFalse negatives: %.2f%%', length(find(bools_b==0))*100/length(bools_b))

% Ex. 3
% Test if different words are in Bloom Filter
U2 = word_list(1001:2000);
bools_c = zeros(1, length(U2));
for i = 1:length(U2)
    bools_c(i) = is_in_bloom_filter(bloom_filter, seeds, k, convertStringsToChars(U2(i)));
end

fprintf('\nFalse positives: %.2f%%\n', length(find(bools_c))*100/length(bools_c))

% Ex. 4
% Theory slide num. 56
m = length(U1);
fprintf('\nTheoric value: %.2f%%', (1-exp(-(k*m)/n))^k*100)
fprintf('\nPractical value: %.2f%%\n', length(find(bools_c))*100/length(bools_c))

%% Ex. 5
n = 8000;
word_list = readlines("wordlist-preao-20201103.txt");
U1 = word_list(1:1000);
false_positives = zeros(1, 7);
k = 4:10;
for j = k-3
    % Initialize Bloom Filter
    bloom_filter = init_bloom_filter(n);
    
    seeds = randi(2^32, k(j), 1);
    % Insert words in Bloom Filter
    for i = 1:length(U1)
        bloom_filter = insert_bloom_filter(bloom_filter, seeds, k(j), convertStringsToChars(U1(i)));
    end

    % Test if different words are in Bloom Filter
    U2 = word_list(1001:11000);
    bools = zeros(1, length(U2));
    for i = 1:length(U2)
        bools(i) = is_in_bloom_filter(bloom_filter, seeds, k(j), convertStringsToChars(U2(i)));
    end
    
    % Calculate false positives
    false_positives(j) = length(find(bools))/length(bools);
end

plot(k, false_positives)
hold on
plot(k, (1-exp(-(k*m)/n)).^k)
legend("Practical values", "Theoretical values")

m = length(U1);
fprintf('\nTheoretical value: %.2f', (n*log(2))/m)
fprintf('\nPractical value: %.2f\n', k(find(false_positives==min(false_positives))))

%% Parte III


% Co´digo base para detec¸a˜o de pares similares
udata=load('u.data');

% Fica apenas com as duas primeiras colunas
u = udata(1:end,1:2);
clear udata;

% Lista de utilizadores
users = unique(u(:,1)); % Extrai os IDs dos utilizadores
Nu = length(users); % Nu´mero de utilizadores

% Constro´i a lista de filmes para cada utilizador
Set = cell(Nu,1); % Usa ce´lulas

for n = 1:Nu % Para cada utilizador
    % Obte´m os filmes de cada um
    ind = find(u(:,1) == users(n));
    % E guarda num array. Usa ce´lulas porque utilizador tem um nu´mero
    % diferente de filmes. Se fossem iguais podia ser um array
    Set{n} = [Set{n} u(ind,2)];
end

% Calcula a distaˆncia de Jaccard entre todos os pares pela definic¸a˜o.
J=zeros(Nu); % array para guardar distaˆnciasv
h= waitbar(0,'Calculating');
tic;
for n1= 1:Nu
    waitbar(n1/Nu,h);
    for n2= n1+1:Nu
        % Adicionar co´digo aqui
        C1 = Set{n1, 1};
        C2 = Set{n2, 1};
        J(n1,n2) = 1 - length(intersect(C1, C2))/length(union(C1, C2));
    end
end
t1 = toc;
delete(h);

% Com base na distaˆncia, determina pares com
% distaˆncia inferior a um limiar pre´-definido

threshold =0.4; % limiar de decisa˜o

% Array para guardar pares similares (user1, user2, distaˆncia)
SimilarUsers= zeros(1,3);
k= 1;
tic;
for n1= 1:Nu
    for n2= n1+1:Nu
        if J(n1,n2) < threshold
            SimilarUsers(k,:) = [users(n1) users(n2) J(n1,n2)];
            k= k+1;
        end
    end
end
t2 = toc;

open('SimilarUsers')

opt = input('Save? (y/n) ', 's');
switch opt
    case 'y'
        save('SimilarUsers.mat', 'SimilarUsers')
    otherwise
end
