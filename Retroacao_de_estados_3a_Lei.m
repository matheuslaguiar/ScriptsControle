% Terceira Lei do Controle por Retroação de Estados
%
% Metodo de Ackerman

ts = 0.83;
Mp = 0.015;
NUM = 1;
DEN = [1 1];
sys = tf(NUM,DEN);
xi = sqrt((log(Mp)/pi)^2 / ((log(Mp)/pi)^2 + 1))
% xi = sqrt{[ln(Mp)/pi]^2 / {[ln(Mp)/pi]^2 + 1} }
wn = 4 / (xi * ts)
% wn = 4 / (xi * ts)
s1 = -xi*wn + 1i*wn* sqrt(1-xi*xi)
s2 = -xi*wn - 1i*wn* sqrt(1-xi*xi)
% s1,2 = -xi*wn +- j*wn* sqrt(1-xi^2)
[a,b,c,d] = tf2ss(NUM,DEN); % matrizes a serem colocadas no simulink
A = [a 0;-c 0]; % A (A expandida)
B = [b;0]; % B (B expandida)
J = [s1 s2]; % J = [s1 s2] 
K = acker(A,B,J); % K = [K1 -KI]
K1 = K(1);
KI = -K(2);