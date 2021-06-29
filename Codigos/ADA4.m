clear; clc;

rb = 3;

thetaSteps = 0:3.6:360;

xCoords = zeros(length(thetaSteps), 1);
yCoords = zeros(length(thetaSteps), 1);
vValues = zeros(length(thetaSteps), 1);
aValues = zeros(length(thetaSteps), 1);
jValues = zeros(length(thetaSteps), 1);

%% Cálculo de valores

i = 1;
for theta = thetaSteps
    if (theta < 30)
        xCoords(i, 1) = -rb*sin(deg2rad(theta));
        yCoords(i, 1) = rb*cos(deg2rad(theta));

        vValues(i, 1) = 0;

        aValues(i, 1) = 0;

        jValues(i, 1) = 0;
    elseif (theta < 105)
        beta = deg2rad(150);
        h = 2;
        s = 2*h*(deg2rad(theta - 30)/beta)^2;
        v = 4*h*(deg2rad(theta - 30)/beta^2);

        xCoords(i, 1) = -(rb + s)*sin(deg2rad(theta)) - v*cos(deg2rad(theta));
        yCoords(i, 1) = (rb + s)*cos(deg2rad(theta)) - v*sin(deg2rad(theta));

        vValues(i, 1) = v;

        aValues(i, 1) = 4*h/beta^2;

        jValues(i, 1) = 0;
    elseif (theta < 180)
        beta = deg2rad(150);
        h = 2;
        s = h*(1-2*(1-deg2rad(theta - 30)/beta)^2);
        v = 4*h*(1-deg2rad(theta - 30)/beta)/beta;

        xCoords(i, 1) = -(rb + s)*sin(deg2rad(theta)) - v*cos(deg2rad(theta));
        yCoords(i, 1) = (rb + s)*cos(deg2rad(theta)) - v*sin(deg2rad(theta));

        vValues(i, 1) = v;

        aValues(i, 1) = -4*h/beta^2;

        jValues(i, 1) = 0;
    elseif (theta < 240)
        s = 2;
        v = 0;

        xCoords(i, 1) = -(rb + s)*sin(deg2rad(theta)) - v*cos(deg2rad(theta));
        yCoords(i, 1) = (rb + s)*cos(deg2rad(theta)) - v*sin(deg2rad(theta));

        vValues(i, 1) = v;

        aValues(i, 1) = 0;

        jValues(i, 1) = 0;
    elseif (theta <= 360)
        beta = deg2rad(120);
        h = 2;
        s = h/2 + (h/2)*cos(pi*deg2rad(theta)/beta);
        v = -pi/beta*(h/2)*sin(pi*deg2rad(theta)/beta);

        xCoords(i, 1) = -(rb + s)*sin(deg2rad(theta)) - v*cos(deg2rad(theta));
        yCoords(i, 1) = (rb + s)*cos(deg2rad(theta)) - v*sin(deg2rad(theta));

        vValues(i, 1) = v;

        aValues(i, 1) = -(pi/beta)^2*(h/2)*cos(pi*deg2rad(theta)/beta);

        jValues(i, 1) = (pi/beta)^3*(h/2)*sin(pi*deg2rad(theta)/beta);
    end

    i = i + 1;
end

%% Animación

thetaRotacionSteps = linspace(0, 2*pi, 180);

movieFrames = struct('cdata', cell(1, length(thetaRotacionSteps)), ...
                     'colormap', cell(1, length(thetaRotacionSteps)));

i = 1;
for thetaRotacion = thetaRotacionSteps
    clf;

    rotatedXCoords = xCoords.*cos(thetaRotacion) - yCoords.*sin(thetaRotacion);
    rotatedYCoords = yCoords.*cos(thetaRotacion) + xCoords.*sin(thetaRotacion);

    maxY = max(rotatedYCoords);

    plot(transpose(rotatedXCoords), transpose(rotatedYCoords));
    hold on;
    plot([-6 6], [0 0], '--', 'color', '#0072BD');
    plot([0 0], [-6 6], '--', 'color', '#0072BD');
    plot([-4 4], [maxY maxY], 'color', '#0072BD');
    plot([-4 -4], [maxY maxY+0.5], 'color', '#0072BD');
    plot([4 4], [maxY maxY+0.5], 'color', '#0072BD');
    plot([-4 -0.5], [maxY+0.5 maxY+0.5], 'color', '#0072BD');
    plot([4 0.5], [maxY+0.5 maxY+0.5], 'color', '#0072BD');
    plot([-0.5 -0.5], [maxY+0.5 6], 'color', '#0072BD');
    plot([0.5 0.5], [maxY+0.5 6], 'color', '#0072BD');
    hold off;

    movieFrames(i) = getframe;

    i = i + 1;
end

myWriter = VideoWriter('ADA4');
myWriter.FrameRate = 60;

open(myWriter);
writeVideo(myWriter, movieFrames);
close(myWriter);

%% Dezplazamiento

figure;

rLenghts = sqrt(xCoords.^2 + yCoords.^2);

plot(thetaSteps, rLenghts);
xlim([0 360]);
title('Desplazamiento');
xlabel('\theta [rad]');
ylabel('Dezplazamiento [in]');

%% Velocidad

figure;

plot(thetaSteps, vValues);
hold on;
plot([0 360], [0 0], '--', 'color', '#0072BD');
hold off;
xlim([0 360]);
title('Velocidad');
xlabel('\theta [rad]');
ylabel('Velocidad [in/rad]');

%% Aceleración

figure;

plot(thetaSteps, aValues);
hold on;
plot([0 360], [0 0], '--', 'color', '#0072BD');
hold off;
xlim([0 360]);
title('Aceleración');
xlabel('\theta [rad]');
ylabel('Aceleración [in/rad^2]');

%% Jerk

figure;

plot(thetaSteps, jValues);
xlim([0 360]);
title('Jerk');
xlabel('\theta [rad]');
ylabel('Jerk [in/rad^3]');