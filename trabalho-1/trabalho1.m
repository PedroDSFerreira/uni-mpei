% b)
T = [
    .1 .3 .4 .5;
    .3 .1 .25 .3;
    .3 .3 .1 .2;
    .3 .3 .25 .2
    ];
v = [1/4; 1/4; 1/4; 1/4];

b = T
% c)
p = (T^9)*v;
c = p(2)
% d)
M= [T-eye(length(T));ones(1,length(T))];
x= zeros(length(T) ,1);
x= [x; 1];

d = M\x

% tempo médio p/h (min/h) que é mostrada a pub. da empresa B entre as 12h e 18h
d(2)*360/6 

% e) 
%p = p('XXA')*p('AB')*p('BB')*p('BA')

T_1 = T^2*v;
p_1 = T_1(1);

v2 = [1; 0; 0; 0];
T_2 = T^3*v2;
p_2 = T_2(2);

v3 = [0; 1; 0; 0];
T_3 = T^4*v3;
p_3 = T_3(2);

v4 = [0; 1; 0; 0];
T_4 = T^5*v4;
p_4 = T_4(1);

p = p_1*p_2*p_3*p_4;
e = p

%% Ex.2
% a)
struct = load("L.mat");
L = struct.L;
N = length(L)
dead_end = find(sum(L) == 0)

% b)
H = zeros(N)
for j=1:N
    k = sum(L(:,j));
    if k ~= 0
        for i=1:N
            H(i,j) = L(i, j)/k;
        end
    else
        H(:,j) = zeros(N,1);
    end
end
% Verificar soma de colunas == 1 (menos em dead ends)
sum(H)

% c)
beta = .85;
% Solve dead ends
H(:, find(sum(H)==0)) = 1/N;

% Solve spider traps
A = beta*H + (1-beta)*(1./(ones(N)*N));

% d)


%% Ex.3

% b)
T = [
    0 .25 0 .25 0 0;
    1/3 0 .5 0 3/8 0;
    1/3 .25 0 .25 0 0;
    1/3 0 .5 0 3/8 0;
    0 .25 0 .25 0 0;
    0 .25 0 .25 .25 0
    ]
% c)
first = 1;
last = 6;
crawl(T, first, last)

% Anexo
function [state] = crawl(H, first, last)
% the sequence of states will be saved in the vector "state"
% initially, the vector contains only the initial state:
    state = [first];
% keep moving from state to state until state "last" is reached:
    while (1)
        state(end+1) = nextState(H, state(end));
        if ismember(state(end), last) % verifies if state(end) is absorbing
            break;
        end
    end
end
% Returning the next state
% Inputs:
% H - state transition matrix
% currentState - current state
function state = nextState(H, currentState)
% find the probabilities of reaching all states starting at the current one:
    probVector = H(:,currentState)'; % probVector is a row vector
    n = length(probVector); %n is the number of states
% generate the next state randomly according to probabilities probVector:
    state = discrete_rnd(1:n, probVector);
end
% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector
function state = discrete_rnd(states, probVector)
    U=rand();
    i = 1 + sum(U > cumsum(probVector));
    state= states(i);
end