% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: main_SIRG_2.m
%
% This is the main file for a economic-epidemic coupled 
% dynamic model, which divides a population in 3 compartments:
%
%   S = susceptible
%   I = infected
%   R = recovered
%   G = guarded
%
% Infection spreads via direct contact between
% a susceptible and infected individual, with no delay.
% No deaths are considered, all infected become recovered.
%
% This model has 7 parameters:
%
%   N     = population size   (number of individuals)
%   beta  = transmission rate (days^-1)
%   gamma = recovery rate     (days^-1)
%   phi   = quantine-in rate  (days^-1)
%   theta = quantine-out rate (days^-1)
%   tq0   = quantine start (days)
%   tq1   = quantine end (days)
%
% This codes uses rhs_SIRG.m to define the ODE system
% and outputs the plots and R_nought value. Calculations
% are made on a day time scale.
%
% Inputs:
%   param: parameters vector      - double array (4x1)
%   IC: initial conditions vector - double array (5X1)
%   tspan: time interval          - double array (?x1)
%   rhs_SIRG: SIRG equations file - .m function file
%
% Outputs:
%   R_nought: basic reproduction number   - double
%   figure 1: model state in time         - inplace figure
%   figure 2: number of new cases in time - inplace figure
%
% In this example the quarantine starts at tq0 = 0 and ends 
% at tq1 = 101. The time interval of analysis is t0=1 and t1=100,
% therefore, the quarantine remains throughout the interval of 
% analysis.
%
% -----------------------------------------------------------
% programmers: Americo Cunha
%
% number of lines: 100
% last update: Jan 27, 2021
% -----------------------------------------------------------

clc
clear
close all

% parameters and initial conditions
% -----------------------------------------------------------  
        
% transmission rate (days^-1)
beta = 1/3;

% recovery rate (days^-1)
gamma = 1/10;

% quantine-in rate (days^-1)
phi = 1/7;

% quantine-out rate (days^-1)
theta = 1/30;

% quarentine start (days)
tq0 = 0;

% quarentine end (days)
tq1 = 101;

N = 1000;
R0 = 0;        % initial recovered    (number of individuals)
G0 = 0;        % initial guarded      (number of individuals)
I0 = 1;        % initial infected     (number of individuals)
S0 = N-I0-R0;  % initial susceptible  (number of individuals)

% initial cumulative infectious (number of individuals)
C0 = I0;
% -----------------------------------------------------------


% display program header on screen
% -----------------------------------------------------------

% computing the basic reproduction number R_nought
R_nought = beta/gamma;

disp(' ')
disp('================================================')
disp('   EPIDEMIC - Epidemiology Educational Code     ')
disp('   by Bruna Pavlack et al.                      ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' --------------------------------------'      )
disp(' ++++++++++ SIRG model +++++++++++++'         )
disp(' --------------------------------------'      )
disp(['  * total population       = ',num2str(N)]   )
disp( '    (individuals)              '             )
disp(['  * transmission rate = ',num2str(beta)]     )
disp( '    (days^-1)           '                    )
disp(['  * recovery rate     = ',num2str(gamma)]    )
disp( '    (days^-1)           '                    )
disp(['  * quantine-in rate  = ',num2str(phi)]      )
disp( '    (days^-1)           '                    )
disp(['  * quantine-out rate = ',num2str(theta)]    )
disp( '    (days^-1)           '                    )
disp(['  * quantine start  = ',num2str(tq0)]        )
disp( '    (days)           '                       )
disp(['  * quantine end    = ',num2str(tq1)]        )
disp( '    (days)           '                       )
disp(['  * R_nought          = ',num2str(R_nought)] )
disp( '    (adimensional)      '                    )
disp(' --------------------------------------'      )
% -----------------------------------------------------------


% integration of the initial value problem
% -----------------------------------------------------------

% parameters vector
param = [N beta gamma phi theta tq0 tq1];

% initial conditions vector
IC = [S0 I0 R0 G0 C0];

% time interval of analysis
   t0 = 1;                  % initial time (days)
   t1 = 100;                % final time   (days)
   dt = 0.1;                % time steps   (days)
tspan = t0:dt:t1;           % interval of analysis
Ndt   = length(tspan);      % number of time steps

% ODE solver Runge-Kutta45
[time, y] = ode45(@(t,y)rhs_SIRG(t,y,param),tspan,IC);

% time series
S = y(:,1);  % susceptible 		(number of individuals)
I = y(:,2);  % infected    		(number of individuals)
R = y(:,3);  % recovered 	        (number of individuals)
G = y(:,4);  % guarded   	        (number of individuals)
C = y(:,5);  % cumulative infectious   (number of individuals)
% -----------------------------------------------------------




% post-rocessing
% -----------------------------------------------------------

% NewCases (per day) computation
tu = 1;                     % time unit (days)
%
% -- tu/dt must be an integer
% -- tu = 1 defines a 'per day' computation
% -- For a 'per week' computation, use tu = 7 and t0 = 7
NewCases = zeros(floor((Ndt-1)/(tu/dt)),1);
for n = 1:length(NewCases)
    NewCases(n) = C((n)*tu/dt +1) - C((n-1)*tu/dt +1);
end


% custom colors
purple = [128,  0,128]/256;
orange = [255,127, 80]/256;

% plot all compartments of SIRG model
figure(1)
hold on
if phi ~= 0
    patch([tq0 tq0 tq1 tq1], [0 N, N 0],...
          [0.9 0.9 0.9],'EdgeColor','none')
end
fig1(1) = plot(time,S);
fig1(2) = plot(time,I);
fig1(3) = plot(time,R);
fig1(4) = plot(time,G);
fig1(5) = plot(time,C);
hold off

    % plot labels
     title('SIRG dynamic model'   );
    xlabel('time (days)'          );
    ylabel('number of individuals');

    % set plot settings
    set(gca,'FontSize',18);
    set(fig1,{'Color'},{'b';'r';'g';purple;'m'});
    set(fig1,{'LineWidth'},{2;2;2;2;2});

    % legend
    leg = {'Suceptibles'; 'Infectious'; 'Recovered';...
    	   'Guarded'; 'Cum. Infectious'};
    legend(fig1,leg,'FontSize',10,'location','northeast');

    % axis limits
    xlim([t0 t1]);
    ylim([0 N]);
    
    
% plot NewCases (per day) of SIRG model
figure(2)
fig2 = scatter([1:length(NewCases)]+1,NewCases);

    % plot labels
     title('NewCases per day (SIRG)'    );
    xlabel('time (days)'                );
    ylabel('number of individuals'      );

    % set plot settings
    set(gca,'FontSize',18);
    set(fig2,{'MarkerFaceColor','MarkerEdgeColor'},{'y','r'});

    % axis limits
    xlim([t0 length(NewCases)]+1);
% -----------------------------------------------------------
