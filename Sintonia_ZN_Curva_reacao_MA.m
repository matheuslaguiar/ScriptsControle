% ZN - Curva de Reação (malha aberta)
% PID
Kp = 1.2*Tau / (K*Teta);
Ti = 2*Teta;
Td = 0.5*Teta;

%PI
%{
    Kp = 0.9*Tau / (K*Teta);
    Ti = 3.33 * Teta;
%}