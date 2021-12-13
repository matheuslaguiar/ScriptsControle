%{
Nivel = TARGET_DATA____Nivel_NivelFiltrado(2,:);
Degrau = TARGET_DATA____Nivel_Degrau(2,:);
Tempo = TARGET_DATA____Nivel_Degrau(1,:);
%}

%{
--------------------------------------------------------------
1a ordem com atraso:
y(k) = a1*y(k-1) + b1*u(k-tau_d)

Psi -> matriz de regressão

            matriz Psi             Theta
y_vet = | y(k-1)  u(k-tau_d) | *    |a1|
        | ...         ...    |      |b1|
        | ...         ...    |

% Este valor de theta minimiza o erro a ser cometido
Theta = (Psi_t * Psi)^-1 * Psi_t * y

--------------------------------------------------------------
2a ordem com atraso:
y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-tau_d)

Psi -> matriz de regressão

            matriz Psi                  Theta
y_vet = | y(k-1) y(k-2) u(k-tau_d) | *    |a1|
        | ...     ...      ...     |      |a2|
        | ...     ...      ...     |      |b1| 

% Este valor de theta minimiza o erro a ser cometido
Theta = (Psi_t * Psi)^-1 * Psi_t * y
--------------------------------------------------------------
2a ordem com atraso E mais um zero:
y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-tau_d) + b2*u(k-tau_d-1)

Psi -> matriz de regressão

            matriz Psi                               Theta
y_vet = | y(k-1) y(k-2) u(k-tau_d) u(k-tau_d-1) | *    |a1|
        | ...     ...      ...        ...       |      |a2|
        | ...     ...      ...        ...       |      |b1| 
        | ...     ...      ...        ...       |      |b2| 

% Este valor de theta minimiza o erro a ser cometido
Theta = (Psi_t * Psi)^-1 * Psi_t * y
--------------------------------------------------------------
%}

% CASO O DEGRAU NAO COMECE EM 0:
% CUIDADO: RECARREGAR OS DADOS CASO RODE O CODIGO NOVAMENTE
%{
t0 = 5;
i = 1;
pos_start = 0;
while (i < length(Tempo))
   if(Tempo(i) >= t0)
       pos_start = i;
       break;
   end
   i = i+1;
end
Degrau = Degrau(pos_start:end);
Saida = Saida(pos_start:end);
Tempo = Tempo(1:length(Saida));
%}

%-------------------------------------------------------------------
% Exemplo:
% Sistema de 2a ordem com atraso de transporte.
% T de amostragem = 0,1s
clear all
load('Identif_ARX_MQ_ex.mat')
% Deslocando Degrau e Saida para y=0
Degrau = Degrau - Degrau(1);
Saida = Saida - Saida(1);
Tempo = t;

% Degrau começa em t0 = 1,9s
t0 = 1.9;
i = 1;
pos_start = 0;
while (i < length(Tempo))
   if(Tempo(i) >= t0)
       pos_start = i;
       break;
   end
   i = i+1;
end
Degrau = Degrau(pos_start:end);
Saida = Saida(pos_start:end);
Tempo = Tempo(1:length(Saida));

% plot para verificar o momento que o sistema começa a responder
% plot(Tempo,Degrau,Tempo,Saida)

% tau_d = 6,1 segundos = 61 amostras
% y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-61)

i = 62;
Psi = 0;
while (i < length(Saida)) 
    Psi(i,1) = Saida(i-1);
    Psi(i,2) = Saida(i-2);
    Psi(i,3) = Degrau(i-61);
    i = i+1;
end

% Theta = (Psi_t * Psi)^-1 * Psi_t * y
Theta = inv(Psi'* Psi)*Psi'* Saida(1:length(Psi));

%Ye = Theta(1)*y(k-1) + Theta(2)*y(k-2) + Theta(3)*u(k-61)

i = 62;
Ye = zeros(62,1); % Preenche as primeiras posições com 0 (atraso)
EQM = 0;

while(i<length(Saida))
    Ye(i) = Theta(1)*Ye(i-1) + Theta(2)*Ye(i-2) + Theta(3)*Degrau(i-61);
    EQM = EQM + (Ye(i) - Saida(i))^2;
    i = i+1;
end
EQM = EQM/length(Ye) % Erro quadrático médio

TempoE = Tempo(1:length(Ye));
plot(TempoE,Ye,'r',Tempo,Saida,'b')