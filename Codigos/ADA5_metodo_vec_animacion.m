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

theta30 = -242.6061;
theta20 = 62.6063;

thetac = theta1 + I2/r3*((theta3 - theta2) - (theta30 - theta20)) - 66.045;

omegac = r1/r3*omega1 + I1/r3*omega1*(sind(theta1 - theta2) ...
         ./ sind(theta3 - theta2) - sind(theta1 - theta3) ...
         ./ sind(theta3 - theta2));

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
    plot([I4 I4+r1*cosd(thetac(i) + 90)], [0 r1*sind(thetac(i) + 90)]);
    plot([Ax(i) Ax(i)+r1*cosd(theta1(i) + 45)], ...
         [Ay(i) Ay(i)+r1*sind(theta1(i) + 45)]);
    hold off;
    xlim([-5 5]);
    ylim([-5 5]);
    drawnow;
end