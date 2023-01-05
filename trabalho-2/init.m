clc
clear all
close all

% Initialization
dic = readcell('u_item.txt', 'Delimiter', '\t');
set = get_users_info();

% Create counting bloom filter
m = length(set);
n = m * 8;
k = round(n*log(2)/m);
seeds = randi(2^32, k);

cbf = init_bloom_filter(n);

for i = 1:length(set)
    for j = 1:length(set{i,1})
        cbf = insert_bloom_filter(cbf, seeds, k, convertStringsToChars(dic{set{i,1}(j), 1}));
    end
end

save 'vars.mat' 'set' 'dic' 'cbf' 'seeds'