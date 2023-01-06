function users = similar_users(id, min_hash)
% Find the 3 most similar users to current user
N = length(min_hash);
Nh = length(min_hash(1,:));
similarity = zeros(N,1);
for i = 1:N
    if i ~= id
        similarity(i) = sum(min_hash(i,:)==min_hash(id,:))/Nh;
    end
end
tmp = ismember(similarity, maxk(similarity, 3));
users = find(tmp, 3);