% Simulacao de modelos lineares discretos
%
% livro texto: 
% https://www.editora.ufmg.br/#/pages/obras?palavra=Aguirre

% LAA 2/6/20

% % Modelo FIR 
% % polinomios usados: B (os demais sao unitarios)

% y(k) = B(q)*u(k)

% Definicao dos coeficientes dos polinomios 
% q -> operador de atraso
% e.g -> u(k)*q^-1 = u(k-1)
%        u(k)*q^-2 = u(k-2)

%B(q) = b1*q^-1 + b2*q^-2
b1=1; b2=0.5; % coeficientes do polinomio B
% entrada
u=0.5*sign(sin((pi/10)*[1:80]));
% ruido branco
ni=randn(size(u))*0.1;

% condicoes iniciais (arbitrarias)
y = zeros(length(u),1);
yo = zeros(length(u),1);
% y -> considera o ni
% yo -> não considera o ni
for k=3:length(u)
    % Eq. 2.42 do livro texto
    y(k)=b1*u(k-1)+b2*u(k-2)+ni(k);
    yo(k)=b1*u(k-1)+b2*u(k-2);
end

plot(u,'k-')
hold on
plot(y,'r-')
hold on
plot(yo,'b-')