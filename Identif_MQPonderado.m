pos100=(0:0.05:1)*288;

k100e=[   0.0116
    0.0176
    0.0077
    0.0271
    0.0250
    0.0521
    0.0677
    0.0605
    0.0510
    0.0960
    0.1301
    0.1144
    0.1220
    0.1318
    0.1486
    0.1699
    0.1752
    0.1680
    0.1802
    0.1915
    0.1915];

% pos100 -> eixo x (instante)
% k100e  -> eixo y (saida)
%{
X -> matriz
x -> valores no eixo x
y -> valores no eixo y

y_vetor = X * theta_vetor
|y1| = | 1 x1 | * |theta1|
|y2|   | 1 x2 |   |theta2|
|y3|   | 1 x3 |
...       ...
|yn|   | 1 xn |

W = matriz dos pesos (importancia)
Wi,i = importancia da i-esima amostra (quanto maior, mais importa)
| w1 0  0 ...  0|
| 0  w2 0 ...  0|
|      ...      |
| 0  0  0 ... wn|

theta_vetor = (X_t * W * X)^-1 * X_t * W *y
theta_vetor = |theta1|
              |theta2|

y_mqp = theta1 + theta2 * x

%}
x1 = ones(21,1); %(vetor coluna)

X = [x1 pos100']; % pos100-> transforma em vetor coluna

y = k100e; % (vetor coluna)

% ex.: amostras 10 e 11 com peso 100
w1 = ones(21,1);
w1(10:11) = 100;
W = diag(w1);

% ' = transposto
% theta_vetor = (X_t * W * X)^-1 * X_t * W *y
Theta = inv(X' * W * X) * X' * W * y; 

y_mq = Theta(1) + Theta(2)*pos100; % y_mq = theta1 + theta2 * x

plot(pos100,y,'x', pos100,y_mq)

