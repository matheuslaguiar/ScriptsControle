%Degrau: SP
%Saida: PV
%Tempo: tempo[s]

% Script para identificação pelo método de Sundaresan

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

Temp = Saida - Saida(1); % desloca pra y(0) = 0

yfinal = Temp(end); % valor final

K = yfinal/Degrau(end);

t_Temp = length(Temp);
i = 1;
t1=0;
t2=0;
while (i < t_Temp) %Obtenção do T2
   if (Temp(i) > 0.853*yfinal)
      t2 = Tempo(i);
      break;
    end
   i = i +1;
end
i = 1;
 while (i < t_Temp) %Obtenção do T1
     if (Temp(i) > 0.353*yfinal)
         t1 = Tempo(i);
         break;
     end
     i = i +1;
 end

Teta = 1.3*t1 - 0.29*t2;
Tau = 0.67*(t2-t1);


% pade
[num,den] = pade(Teta,1); %Teta-> atraso, N->ordem
sys_pade = tf(num,den);
sys = tf(K, [Tau 1]);
sys_f = series(sys,sys_pade);


%se nao precisar de pade
%sys_f = tf(K ,[Tau 1],'InputDelay',Teta);

[saida,tempo] = step(sys_f);


saida = Degrau(end)*saida;
saida = saida + Saida(1);

plot(tempo,saida,Tempo,Saida,Tempo,Degrau)