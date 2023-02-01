function word = word_gen()
% Generate random word w/size according to prob

prob = rand();
if prob < 0.4
    word_size = 5;
else
    word_size = 8;
end

% gerar random de 'a' a 'z'
word = char(randi([double('a'), double('z')], 1,word_size));
end
