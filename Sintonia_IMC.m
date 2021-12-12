% Metodo IMC – Metodo do Modelo interno
% ts = tempo de acomodacao
% Tau e Teta -> Identificacao
ts = 400;
lambda = ts / 4;
Kp = (2*Tau + Teta) / (K * (2*lambda + Teta));
Ti = Tau + (Teta / 2);
Td = Tau*Teta / (2*Tau + Teta);