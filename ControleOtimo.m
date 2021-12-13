% Controle LQR - "Controle �timo"

% Matrizes espa�o dos estados:
A = [0 1;
    0.01 0];
B = [0;
    1];
C = [1 0];
D = 0;

% Lei de controle
Q = [1 0;  % Penalidade do erro angular -> quanto maior, mais r�pido
     0 1];  % Penalidade da varia��o do erro
R = 1;    % Penalidade custo -> quanto maior, menos energia consumida

K = lqr(A,B,Q,R)

% Sistema em malha fechada
sys = ss((A-B*K), B, C, D);

% Plots -> executar primeiramente o simulink
%{
subplot(2,1,1)
plot(tempo,ControlX1)
title('Vari�vel controlada')
grid on
subplot(2,1,2)
plot(tempo, energia)
title('Energia consumida pelo tempo')
grid on
%}