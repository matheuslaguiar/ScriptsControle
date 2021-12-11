% Modelo ARX 
% polinomios usados: A e B (os demais sao unitarios)

%{
De forma geral
A(q)*y(k) = B(q)*u(k)   +           ni(k)
y(k) = B(q)/A(q) * u(k) + ((((1/A(q) * ni(k))))
                          (parcela estocástica)

A(q) = 1 - a1*(q^-1) - a2*(q^-2) - ... - a_ny*(q^-ny) (acompanha y(k))
ny -> ordem da F.T.

B(q) = b1*(q^-tau_d) + b2*(q^(-tau_d-1))+...+ b_nu*(q^-nu) (acompanha u(k))
tau_d -> atraso de transporte
%}

% Definicao dos coeficientes dos polinomios 
% q -> operador de atraso
% e.g -> u(k)*q^-1 = u(k-1)
%        u(k)*q^-2 = u(k-2)

% A(q) = 1 - a1*(q^-1) - a2*(q^-2)
% B(q) = b1 * q^-1
a1=1.5; a2=-0.7; % coeficientes do polinomio A
b1=1; % coeficientes do polinomio B

% entrada
u= zeros(50,1); %Degrau Unitario Atrasado de 10 amostras
u(10:50,1) = 1;

ni = randn(length(u))*0.1;

% condicoes iniciais (arbitrarias)
y = zeros(length(u),1);
yo = zeros(length(u),1);
% y -> considera o ni
% yo -> não considera o ni

% Para este caso, teremos esta equação a diferenças:
%                                   vvvvv  atraso = 1
% y(k) = a1*y(k-1) + a2*y(k-2) + b1*u(k-1)     + ni(k) 
%                       ^^^^^^ 2a ordem
 for k=3:length(u)
    y(k)=a1*y(k-1)+a2*y(k-2)+b1*u(k-1)+ni(k);
    yo(k)=a1*yo(k-1)+a2*yo(k-2)+b1*u(k-1);
 end

plot(1:50,u,'g')
hold on
plot(1:50,y,'r*')
hold on
plot(1:50,yo,'b*')