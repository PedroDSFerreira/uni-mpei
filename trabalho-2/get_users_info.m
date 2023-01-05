function [Set, users, Nu] = get_users_info()
% Código base para deteção de pares similares
udata=load('u.data');

% Fica apenas com as três primeiras colunas
u = udata(1:end,1:3);
clear udata;

% Lista de utilizadores
users = unique(u(:,1)); % Extrai os IDs dos utilizadores
Nu = length(users); % Número de utilizadores

% Constrói a lista de filmes para cada utilizador
Set = cell(Nu,1); % Usa células

for n = 1:Nu % Para cada utilizador
    % Obtém os filmes de cada um
    ind = find(u(:,1) == users(n));
    % E guarda num array. Usa células porque utilizador tem um número
    % diferente de filmes
    Set{n} = [Set{n} u(ind,2) u(ind,3)];
end

end

