%1a
a = [.2 0 .3 .1 .45];

T = [
    0 0 0 0 0 0;
    a(1) 0 0 0 0 0;
    0 0 0 a(4) a(5) 0;
    0 0 a(3) 0 1-a(5) 0;
    1-a(1) 1 1-a(3) 0 0 0;
    0 0 0 1-a(4) 0 1
];

%1b
% P(1-5)*P(5-4)*P(4-Meta)
v0 = [1; 0; 0; 0; 0; 0];
v0 = T*v0;
p1 = v0(5);
v0 = T*v0;
p2 = v0(4);
v0 = T*v0;
p3 = v0(6);
p = p1*p2*p3;


%1c
Q = [
    0 0 0 0;
    a(1) 0 0 0;
    0 0 a(4) a(5);
    0 a(3) 0 1-a(5)
];

F = (eye(4)-Q)^(-1);

num_houses = sum(sum(F));

%%
%2a

m = 300;
p = 0.03;
k = 1;

n = round(-m/(log(1-p)));

%2b
bf = init_bloom_filter(n);

words = cell(1,m);
% Insert vals in bloom filter
for i=1:m
    word = word_gen();
    bf = insert_bloom_filter(bf, k, word);
    words{i} = word;
end

false_positives = 0;
for j=1:m
    if is_in_bloom_filter(bf, k, words{j})
        false_positives = false_positives+1;
    end
end

prob = false_positives/m


