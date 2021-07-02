clear; clc;

% (* Declaracion de variables *)
lambda = 1;
a = 0.8;
r1 = 1;
r2 = 1.5;
r3 = 1;
d = 3.1;

omega1 = 1.875;

b = r1 + r2
c = r2 + r3

s = (a + b + c + d) / 2

delta = acosd((2*s*(s - d)) / ((a + b)*c) - 1)
gamma = asind(c/d*sind(delta))

K1 = (b^2 + c^2 - d^2 - a^2) / (2*b*c)
K2 = (a*d) / (b*c)

C = 1 + r2/r1

% (*  Declaracion de function_handler *)
theta = @(gamma1) gamma + gamma1;

delta1 = @(gamma1) acosd(K1 + K2*cosd(theta(gamma1)));

epsilon = @(gamma1) theta(gamma1) - gamma - C*delta + C*delta1(gamma1);

omega3 = @(gamma1) omega1.*(1 + (K2.*C*sind(theta(gamma1))) ...
         ./ (sind(delta1(gamma1))));

% (* Generacion de graficas *)
figure;
subplot(2, 1, 1);
fplot(epsilon, [0 360]);
title('Desplazamiento contra ángulo');
xlabel('\gamma_{1} [deg]');
ylabel('\epsilon [deg]');
grid;
grid minor;

subplot(2, 1, 2);
fplot(omega3, [0 360]);
title('Velocidad contra ángulo');
xlabel('\gamma_{1} [deg]');
ylabel('\omega_{3} [rad/s]');
grid;
grid minor;