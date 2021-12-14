%% Initialize wind farm layout, and wind direction

% wind turbine layout
x = [10, 80, 150];
y = [10, 120, 230];

% wind direction
thk = 0;

% new coordinate system for WT layout with wind direction fully in x
xk = zeros(1, length(x));
yk = zeros(1, length(x));

% convert original layout to new coordinates
for i = 1:length(x)
    xk(i) = x(i)*cos(thk) + y(i)*sin(thk);
    yk(i) = -x(i)*sin(thk) + y(i)*cos(thk);
end

% for saving output
save = 0;

WFn = 0;
fname = ['WF', num2str(WFn), '.xlsx'];          % save excel file to
figname = ['WF', num2str(WFn), 'layout.png'];   % save figure layout to

%% Plot turbine layout

% wind turbine individual labels
lbl = strings(length(x), 1);
for i=1:length(x)
    lbl(i) = ['WT', num2str(i)];
end


plt_title = ['Turbine layout for Wind Farm ', num2str(WFn)];

hold on
for i = 1:length(x)
    scatter(xk(i), yk(i), 60, 'filled','DisplayName', lbl(i))
end

xlabel('Distance downwind (m)', 'fontsize', 15)
ylabel('Distance cross-wind (m)', 'fontsize', 15)
title(plt_title, 'fontsize', 16)
legend('Location', 'best', 'fontsize', 14)
hold off


%% calculate wind speed, vij

vo = 1;         % inflow wind speed
ct = 1;         % thrust coefficient of WT at vo
alpha = 1;      % wake decay coefficient
Rr = 40;        % radius of turbine rotor
Ar = pi*Rr^2;   % rotor area
Cp = 1;         % capacity factor
eff = 1;        % mechanical to electrical conversion efficiency 

% initialize matrices to store interactions between WTi,j
xij = zeros(length(yk), length(xk));
Vij = zeros(length(yk), length(xk));
Rij = zeros(length(yk), length(xk));
dij = zeros(length(yk), length(xk));
Aij = zeros(length(yk), length(xk));


for i=1:length(xk)
    for j=1:length(xk)
        
        % if WTi is downwind of WTj (then WTj wake has influence on WTi)
        if xk(i) > xk(j)
        
            % get distance between WTi and WTj in downwind direction
            xij(i, j) = xk(i) - xk(j);

            % calculate wind speed at WTi position
            Vij(i, j) = vo*( 1 - (1-sqrt(1-ct)) / (1+alpha*(xij(i, j)/Rr))^2 );
            
            % calculate wake zone radius at WTi position
            Rij(i, j) = alpha*xij(i, j) + Rr;  
            
            % distance between turbine centers
            dij(i, j) = abs(yk(i) - yk(j));
            
            % get area of overlap
            Aij(i, j) = calcAol(Rij(i, j), Rr, dij(i, j));
            
        end
    end
end

%% Calculate "wake influence factor"
Mijk = (Aij./Ar).^2 ./ ( 1 + alpha.*(xij./Rr)).^4;

%% Calculate effective wind speed experienced by WTi 

% initialize storage for effective wind speed
Vi = zeros(length(yk), 1);

for i=1:length(xk)
    
    % set WTj contributions to WTi experienced eff wind speed to 0
    jterm = 0;
    
    % sum all WTj influences on Wti
    for j=1:length(xk)
        jc = (Aij(i, j)/Ar)^2 * (1 - Vij(i, j)/vo)^2;
        jterm = jterm + jc;
    end
    
    % get effective wind speed experienced by WTi
    Vi(i) = vo*(1 - sqrt(jterm));
    
end

%% Calculate power production

Pi = WF_power(Vi, Ar, Cp, eff);
Ptot = sum(Pi);

%% Store wind farm info to file

WT = (1:length(xk)).';

layout = table(WT, x.', y.', xk.', yk.');
layout.Properties.VariableNames = {'WT', 'WTx', 'WTy', 'WTx_newcoords', 'WTy_newcoords'};

inputs = table(thk, vo, ct, alpha, Rr, Cp, eff);
inputs.Properties.VariableNames = {'Wind_dir', 'Inflow_wind_speed', 'thrust_coeff', 'wake_decay_coeff', 'Rotor_rad', 'Capacity_factor', 'Conversion_eff'};

outputs = table(WT, xij, Vij, Rij, dij, Aij, Mijk, Pi);

if save
    writetable(inputs,fname,'Sheet',3,'Range','A1');
    writetable(layout,fname,'Sheet',2,'Range','A1');
    writetable(outputs,fname,'Sheet',1,'Range','A1');
    
    saveas(gcf, figname);
    
end

%% Calculate power production by WF

% expected power production of all wind turbines in a farm
function P = WF_power(Vi, Ar, Cp, eff)
% WF_POWER: calculate expected power production of all wind turbines in a
% farm.

% density of air (kg/m^3)
rho = 1.225;
% betz limit
Cbetz = 0.593;

% initialize storage for power production of each turbine
P = zeros(length(Vi), 1);

for i = 1:length(Vi)
    P(i) = 0.5*rho*Ar*Cbetz*Cp*eff * Vi(i)^3;
end

end


%% function to calculate overlapping area

function Aol = calcAol(Rij, Rr, dij)
% Aol: calculate overlapping area of upwind turbine wake and downwind
% turbine rotor
%
% INPUTS
%
% Rij: double, wake zone radius at downwind turbine position
% Rr: double, radius of turbine rotor at downwind position
% dij: double, distance between turbine centers
%
% OUTPUTS
%
% Aol: double, area of overlap between upwind turbine wake and downwind
% turbine rotor

% full wake
if dij <= (Rij-Rr)
    Aol = pi*Rr^2;
    
% out of wake
elseif dij >= (Rij+Rr)
    Aol = 0;
  
% partial wake
else
    % get alpha from law of cosines
    a = acos((Rij^2 + dij^2 - Rr^2)/(2*Rij*dij));
    % get beta from law of cosines
    b = acos((Rr^2 + dij^2 - Rij^2)/(2*Rr*dij));
    
    % get "semi-perimeter"
    s = (Rij + dij + Rr)/2;
    
    % get A of triangle from heron's formula
    A = sqrt(s*(s-Rr)*(s-dij)*(s-Rij));
    
    % get area of overlap in partial wake
    Aol = 2*a*Rij^2 + 2*b*Rr^2 - 2*A;
end
    
end

