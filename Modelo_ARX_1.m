% Exemplo de Modelo ARX
% Script mais bem comentado -> Modelo_ARX.m

% Simulacao de modelos lineares discretos
% videos: 
%
% livro texto: 
% https://www.editora.ufmg.br/#/pages/obras?palavra=Aguirre

% LAA 2/6/20
clear all
% Definicao dos coeficientes dos polinomios 
a1=1.5; a2=-0.7; % coeficientes do polinomio A
b1=1; b2=0.5; % coeficientes do polinomio B
% y(k) = a1y(k-1)+a2y(k-2)+b1u(k-1)+b2u(k-2)

% entrada
u= zeros(50,1); %Degrau Unitario Atrasado de 10 amostras
u(5:50,1) = 1;
m = size(u);
m = m(1);
y1 = zeros(m);
y2 = zeros(m);
y3 = zeros(m);
for k=5:m
    % Atraso Puro de Tempo 1 
    y1(k)=a1*y1(k-1)+a2*y1(k-2)+b1*u(k-1)+b2*u(k-2);
end

plot(y1(:,1),'r*')

for k=5:m
    % Atraso Puro de Tempo 1 
    y2(k)=a1*y2(k-1)+a2*y2(k-2)+b1*u(k-3)+b2*u(k-4);
end

for k=10:m
    % Atraso Puro de Tempo 1 
    y3(k)=a1*y3(k-1)+a2*y3(k-2)+b1*u(k-7)+b2*u(k-9);
end

% plot(u)
 plot(y1(:,1),'r*')
 hold on
 plot(y2(:,1),'b*')
 hold on
 plot(y3(:,1),'g*')
