clc
clear all
close all

%% Ex. 1

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
    subplot(4,1,2)
    histogram(simulation_2{i, 1}, 100)
    subplot(4,1,3)
    histogram(simulation_3{i, 1}, 100)
    subplot(4,1,4)
    histogram(simulation_4{i, 1}, 100)
end