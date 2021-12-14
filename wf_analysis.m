
%% control
wf0 = readtable('WF0.xlsx');

x0 = [10, 80, 150];
y0 = [10, 120, 230];

figure
hold on
scatter([1, 2, 3], wf0.Pi, 70, 'filled')

xticks([1, 2, 3])
xlabel('Wind turbine', 'fontsize', 14)
ylabel('Power production [W]', 'fontsize', 14)
title({'Power production of each wind turbine', 'in control scenario (WF0)'}, 'fontsize', 16)
% saveas(gcf, 'pwr_control.png');

%% changing downwind dist

wf1 = readtable('change_xdist/WF1.xlsx');
wf2 = readtable('change_xdist/WF2.xlsx');
wf3 = readtable('change_xdist/WF3.xlsx');
wf4 = readtable('change_xdist/WF4.xlsx');
% distance between wind turbines in each dif run
xdist = [70, 80, 90, 100, 110];

% extract P from windfarm output files
P1wf1 = [wf0.Pi(1), wf1.Pi(1), wf2.Pi(1), wf3.Pi(1), wf4.Pi(1)];
P2wf1 = [wf0.Pi(2), wf1.Pi(2), wf2.Pi(2), wf3.Pi(2), wf4.Pi(2)];
P3wf1 = [wf0.Pi(3), wf1.Pi(3), wf2.Pi(3), wf3.Pi(3), wf4.Pi(3)];

figure
hold on
scatter(xdist, P1wf1,60, 'filled', 'DisplayName', 'WT1')
scatter(xdist, P2wf1,60, 'filled', 'DisplayName', 'WT2')
scatter(xdist, P3wf1,60, 'filled', 'DisplayName', 'WT3')
legend('Location', 'best', 'fontsize', 13)
xlabel('Downwind distance between turbines  [m]', 'fontsize', 14)
ylabel('Power production [W]', 'fontsize', 14)
title({'Power production versus', 'downwind distance between turbines'}, 'fontsize', 16)
hold off
%saveas(gcf, 'pvsxdist.png');

%% changing crosswind dist
wf5 = readtable('change_ydist/WF5.xlsx');
wf6 = readtable('change_ydist/WF6.xlsx');
wf7 = readtable('change_ydist/WF7.xlsx');
wf8 = readtable('change_ydist/WF8.xlsx');
% crosswind distance between turbines
ydist = [110, 100, 90, 80, 70];

% extract P from windfarm output files
P1wf5 = [wf0.Pi(1), wf5.Pi(1), wf6.Pi(1), wf7.Pi(1), wf8.Pi(1)];
P2wf5 = [wf0.Pi(2), wf5.Pi(2), wf6.Pi(2), wf7.Pi(2), wf8.Pi(2)];
P3wf5 = [wf0.Pi(3), wf5.Pi(3), wf6.Pi(3), wf7.Pi(3), wf8.Pi(3)];

figure
hold on
scatter(ydist, P1wf5,60, 'filled', 'DisplayName', 'WT1')
scatter(ydist, P2wf5,60, 'filled', 'DisplayName', 'WT2')
scatter(ydist, P3wf5,60, 'filled', 'DisplayName', 'WT3')
legend('Location', 'best', 'fontsize', 13)
xlabel('Crosswind distance between turbines [m]', 'fontsize', 14)
ylabel('Power production [W]', 'fontsize', 14)
title({'Power production versus', 'crosswind distance between turbines'}, 'fontsize', 16)
hold off
%saveas(gcf, 'pvsydist.png');

%% changing rotor radius
wf9 = readtable('change_Rr/WF9.xlsx');
wf10 = readtable('change_Rr/WF10.xlsx');
wf11 = readtable('change_Rr/WF11.xlsx');
wf12 = readtable('change_Rr/WF12.xlsx');

% rotor radius
Rr = [40, 50, 60, 70, 80];

% extract P from windfarm output files
P1wf9 = [wf0.Pi(1), wf9.Pi(1), wf10.Pi(1), wf11.Pi(1), wf12.Pi(1)];
P2wf9 = [wf0.Pi(2), wf9.Pi(2), wf10.Pi(2), wf11.Pi(2), wf12.Pi(2)];
P3wf9 = [wf0.Pi(3), wf9.Pi(3), wf10.Pi(3), wf11.Pi(3), wf12.Pi(3)];

figure
hold on
scatter(Rr, P1wf9,60, 'filled', 'DisplayName', 'WT1')
scatter(Rr, P2wf9,60, 'filled', 'DisplayName', 'WT2')
scatter(Rr, P3wf9,60, 'filled', 'DisplayName', 'WT3')
legend('Location', 'best', 'fontsize', 13)
xlabel('Rotor radius [m]', 'fontsize', 14)
ylabel('Power production [W]', 'fontsize', 14)
title({'Power production versus', 'turbine rotor radius'}, 'fontsize', 16)
hold off
%saveas(gcf, 'pvsRr.png');

%% changing wind angle
wf13 = readtable('change_th/WF13.xlsx');
wf14 = readtable('change_th/WF14.xlsx');
wf15 = readtable('change_th/WF15.xlsx');
wf16 = readtable('change_th/WF16.xlsx');

% wind angle
th = [0, pi/8, pi/4, 3*pi/8, pi/2];

% extract P from windfarm output files
P1wf13 = [wf0.Pi(1), wf13.Pi(1), wf14.Pi(1), wf15.Pi(1), wf16.Pi(1)];
P2wf13 = [wf0.Pi(2), wf13.Pi(2), wf14.Pi(2), wf15.Pi(2), wf16.Pi(2)];
P3wf13 = [wf0.Pi(3), wf13.Pi(3), wf14.Pi(3), wf15.Pi(3), wf16.Pi(3)];

figure
hold on
scatter(th, P1wf13,60, 'filled', 'DisplayName', 'WT1')
scatter(th, P2wf13,60, 'filled', 'DisplayName', 'WT2')
scatter(th, P3wf13,60, 'filled', 'DisplayName', 'WT3')
legend('Location', 'best', 'fontsize', 13)
xlabel('Wind angle [radians]', 'fontsize', 14)
ylabel('Power production [W]', 'fontsize', 14)
title({'Power production versus', 'wind angle'}, 'fontsize', 16)
hold off
% saveas(gcf, 'pvsth.png');

%% total power comparison
P0 = sum(wf0.Pi);
P1 = sum(wf1.Pi);
P2 = sum(wf2.Pi);
P3 = sum(wf3.Pi);
P4 = sum(wf4.Pi);
P5 = sum(wf5.Pi);
P6 = sum(wf6.Pi);
P7 = sum(wf7.Pi);
P8 = sum(wf8.Pi);
P9 = sum(wf9.Pi);
P10 = sum(wf10.Pi);
P11 = sum(wf11.Pi);
P12 = sum(wf12.Pi);
P13 = sum(wf13.Pi);
P14 = sum(wf14.Pi);
P15 = sum(wf15.Pi);
P16 = sum(wf16.Pi);

P = [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12, P13, P14, P15, P16];


scatter([0:16], P, 60, 'filled');
xticks([1:length(P)])
xlabel('Wind Farm', 'fontsize', 15)
ylabel('Power production [W]', 'fontsize', 15)
title({'Power production for each unique wind farm setup'}, 'fontsize', 17)
ax = gca;
ax.XGrid = 'on';
% saveas(gcf, 'totP.png');

