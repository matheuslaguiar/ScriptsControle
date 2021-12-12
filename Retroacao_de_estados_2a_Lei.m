% Segunda Lei do Controle por Retroação de Estados

% Metodo algebrico
% |s*I - A + B*K| = (s-polo_1)(s-polo_2)...(s-polo_n)

% Metodo de Ackerman

% Funcao de transferencia
% NUM = 1370;
% DEN = [1 50 0]; % há um polo na origem
% se nao for dado as matrizes
% [a,b,c,d] = tf2ss(NUM, DEN);

% matrizes
a=[[0 1]; [0 -50]];
b=[0;1370];
c=eye(2); % matriz identidade
d=0;

J = [-4.5 -180]; % polos desejados

K = acker(a,b,J);
K1 = K(1)
K2 = K(2)

% Rodar o simulink e depois:
plot(tempo,ref,tempo,x1,tempo,x2)