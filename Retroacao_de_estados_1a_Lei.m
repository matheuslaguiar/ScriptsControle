% Primeira Lei do Controle por Retroação de Estados

% Metodo algebrico
% |s*I - A + B*K| = (s-polo_1)(s-polo_2)...(s-polo_n)

% Metodo de Ackerman

x1_ini = 0.05; % posicao inicial
x2_ini = 0.05;
a = [0 1; -40 -3];
b = [0 ; 40];
s1 = -1.8 + 1i*7.25;
s2 = -1.8 - 1i*7.25;
J = [s1 s2];
K = acker(a,b,J);
K1 = K(1);
K2 = K(2);

% Rodar o simulink e depois:
%{
subplot(2,1,1)
plot(tempo,x1,tempo,ControlX1,'r')
grid on
title('X1')
subplot(2,1,2)
plot(tempo,x2,tempo,ControlX2,'r')
grid on
title('X2')
%}
