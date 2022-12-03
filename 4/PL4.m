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
    hashtable = cell(1, table_sizes(i));
    colisions = 0;
    tic
    for j=1:N
        hashcode = string2hash(keys{j}, 'djb2');
        index = abs(mod(hashcode, table_sizes(i)))+1;
        if isempty(hashtable{index})
            hashtable{index} = hashcode;
        else
            colisions = colisions + 1;
            hashtable{index}(end+1) = hashcode;
        end
    end
    simulation_1{i, 1} = hashtable;
    simulation_1{i, 2} = colisions;
    simulation_1{i, 3} = toc;
end


simulation_2 = cell(3);
for i=1:length(table_sizes)
    hashtable = cell(1, table_sizes(i));
    colisions = 0;
    tic
    for j=1:N
        hashcode = string2hash(keys{j}, 'sdbm');
        index = abs(mod(hashcode, table_sizes(i)))+1;
        if isempty(hashtable{index})
            hashtable{index} = hashcode;
        else
            colisions = colisions + 1;
            hashtable{index}(end+1) = hashcode;
        end
    end
    simulation_2{i, 1} = hashtable;
    simulation_2{i, 2} = colisions;
    simulation_2{i, 3} = toc;
end

simulation_3 = cell(3);
seed = 123;
for i=1:length(table_sizes)
    hashtable = cell(1, table_sizes(i));
    colisions = 0;
    tic
    for j=1:N
        hashcode = DJB31MA(keys{j}, seed);
        index = abs(mod(hashcode, table_sizes(i)))+1;
        if isempty(hashtable{index})
            hashtable{index} = hashcode;
        else
            colisions = colisions + 1;
            hashtable{index}(end+1) = hashcode;
        end
    end
    simulation_3{i, 1} = hashtable;
    simulation_3{i, 2} = colisions;
    simulation_3{i, 3} = toc;
end

simulation_4 = cell(3);
for i=1:length(table_sizes)
    hashtable = cell(1, table_sizes(i));
    colisions = 0;
    tic
    for j=1:N
        hashcode = hashstring(keys{j}, table_sizes(i));
        index = hashcode+1;
        if isempty(hashtable{index})
            hashtable{index} = hashcode;
        else
            colisions = colisions + 1;
            hashtable{index}(end+1) = hashcode;
        end
    end
    simulation_4{i, 1} = hashtable;
    simulation_4{i, 2} = colisions;
    simulation_4{i, 3} = toc;
end