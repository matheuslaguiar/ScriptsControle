% Calculo dos ganhos do observador de estados

% Metodo algebrico
% |s*I - A + l*C| = (s-lambda_1)(s-lambda_2)...(s-lambda_n)

% Metodo de Ackerman
a = [-1 1; 1 -2];
b = [1;0];
c = [1 0];

% verifica se é observavel
ob = obsv(a,c);
rank(ob) % deve ser igual a ordem do sistema 

% obs.: os polos do observador devem ser de 2 a 3 vzs
%       o valor dos polos naturais

% polos naturais: verificar se o sistema eh estavel ( parte real <0)
eig(a) % det(lambda_sistema*I - a) = 0 -> encontrar lambda_sistema

% polos do observador:
lambda = [-5 -6];

% vetor de ganhos do observador:
l = acker(a,c',lambda) % a e c' devem ter o mesmo numero de linhas