function display_suggestions(movies)
for i=1:length(movies)
    disp(['- ' convertStringsToChars(movies(i))])
end
end

