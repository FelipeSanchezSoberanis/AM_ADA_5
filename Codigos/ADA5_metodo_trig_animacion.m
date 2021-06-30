clear; clc;

I4 = 3.1;
I1 = 0.8;
I2 = 2.5;
I3 = 2.5;

r1 = 1;
r2 = 1.5;
r3 = 1;

gamma = 45.855;

theta1 = linspace(0 + gamma, 360 + gamma);
omega1 = 1.875;

O4A = sqrt(I4^2 + I1^2 - 2*I4*I1*cosd(theta1));

beta = asind(I1./O4A.*sind(theta1));
phi = acosd((I2^2 + O4A.^2 - I3^2) ./ (2*I2*O4A));
delta = asind(I2/I3*sind(phi));

theta2 = phi - beta;
theta4 = -(beta + delta);
theta3 = theta4 - 180;

O2x = zeros(1, length(theta1));
O2y = zeros(1, length(theta1));

Ax = I1*cosd(theta1);
Ay = I1*sind(theta1);

Bx = I4 + I3*cosd(theta3);
By = I3*sind(theta3);

s = (I1 + I2 + I3 + I4) / 2;

delta = acosd((2*s*(s - I4)) / ((I1 + I2)*I3) - 1);
gamma = asind(I3/I4*sind(delta));

K1 = (I2^2 + I3^2 - I4^2 - I1^2) / (2*I2*I3);
K2 = (I1*I4) / (I2*I3);

I3 = 1 + r2/r1;

theta = @(gamma1) gamma + gamma1;

delta1 = @(gamma1) acosd(K1 + K2*cosd(theta(gamma1)));

epsilon = @(gamma1) theta(gamma1) - gamma - I3*delta + I3*delta1(gamma1);

omega3 = @(gamma1) omega1.*(1 + (K2.*I3*sind(theta(gamma1))) ...
         ./ (sind(delta1(gamma1))));

epsilonValues = epsilon(theta1);

set(0, 'DefaultLineLineWidth', 2);
for i = 1:length(theta1)
    clf;
    plot([O2x(i) Ax(i)], [O2y(i) Ay(i)], 'color', '#0072BD');
    hold on;
    plot([Ax(i) Bx(i)], [Ay(i) By(i)], 'color', '#0072BD');
    plot([Bx(i) I4], [By(i) 0], 'color', '#0072BD');
    viscircles([Ax(i), Ay(i)], r1);
    viscircles([Bx(i), By(i)], r2);
    viscircles([I4, 0], r3);
    plot([I4 I4+r1*cosd(epsilonValues(i))], [0 r1*sind(epsilonValues(i))]);
    plot([Ax(i) Ax(i)+r1*cosd(theta1(i) + 45)], ...
         [Ay(i) Ay(i)+r1*sind(theta1(i) + 45)]);
    hold off;
    xlim([-5 5]);
    ylim([-5 5]);
    drawnow;
end