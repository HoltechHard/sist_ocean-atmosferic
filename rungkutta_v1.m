function R = rungkutta_v1(f, a, b, ya, M)

% f: function passed like a string
% a: low limit
% b: upper limit
% ya: initial conditions
% M: number of iterations
% X: vector of abscisa
% Y: vector of ordinates
% R = [X', Y'] : output

% step
h = (b-a)/M;
% initialize vector X
X = zeros(1, M+1);
% initialize vector Y
Y = zeros(1, M+1);
% split interval [a, b] using step h
X = a:h:b;
% define initial conditions
Y(1) = ya;

syms x y

% cycle for M iterations
for j=1:M
    x = X(j)
    y = Y(j)
    k1 = feval(f, x, y);
    k2 = feval(f, x + h/2, y + h/2 * k1);
    k3 = feval(f, x + h/2, y + h/2 * k2);
    k4 = feval(f, x + h, y + h * k3);
    Y(j+1) = Y(j) + h/6 * (k1 + 2*k2 + 2*k3 + k4);
end

R = [X' Y'];


% consider the case:
% dy/dx = x^2 - y
% y(0) = 1
% y(x) = -e^-x + x^2 - 2*x + 2  ==> solucion exacta 
% h = 0.2  ==> N = 2
% h = 0.1  ==> N = 4
% compute y(0.4) = ??




