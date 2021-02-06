% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: check_error_SIRG.m
%
% This is a main file for check the rhs_SIRQ.m
% function constraints
%
% Inputs:
%   t: time                       - double
%   y: state vector               - double array (5x1)
%   param: parameters vector      - double array (?x1)
%   rhs_SIRQ: SIRQ equations file - .m function file
%
% Output:
%   log                           - interface messages
% -----------------------------------------------------------
% programmers: Michel Tosin
%
% number of lines: 180
% last update: Jan 29, 2021
% -----------------------------------------------------------

clc
clear
close all

% display program header
% -----------------------------------------------------------
disp(' ')
disp('================================================')
disp('   EPIDEMIC - Epidemiology Educational Code     ')
disp('   by A. Cunha, E. Dantas, et al.               ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' -----------------------------------------------')
disp(' ++++++++++++++ rhs_SIR checking +++++++++++++++')
% -----------------------------------------------------------

% Case 1: length(param) < 7 
% -----------------------------------------------------------  
t = 1;              % time
y = [999 1 0 0 1];  % state vector
param = [1000 0.5 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 1: length(param) < 7')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 2: length(param) > 7 
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 2: length(param) > 7')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 3: mod(param(1),1) ~= 0
% -----------------------------------------------------------  
param = [1000.25 0.5 0.5 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 3: mod(param(1),1) ~= 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% -----------------------------------------------------------

% Case 4: param(1) < 0
% -----------------------------------------------------------  
param = [-1000 0.5 0.5 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 4: param(1) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 5: param(2) < 0
% -----------------------------------------------------------  
param = [1000 -0.5 0.5 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 5: param(2) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 6: param(3) < 0
% -----------------------------------------------------------  
param = [1000 0.5 -0.5 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 6: param(3) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 7: param(4) < 0
% -----------------------------------------------------------  
param = [1000 0.5 0.5 -0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 7: param(4) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 8: param(5) < 0
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 -0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 8: param(5) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 9: param(6) < 0
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 0.5 -0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 9: param(6) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 10: param(7) < 0
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 0.5 0.5 -0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 10: param(7) < 0')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 11: param(4) > 1
% -----------------------------------------------------------  
param = [1000 0.5 0.5 1.1 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 11: param(4) > 1')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 12: param(5) > 1
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 1.1 0.5 0.5]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 12: param(5) > 1')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 13: param(6) > param(7)
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 0.5 5 4]; % parameters vector

try  
    rhs_SIRG(t,y,param)
catch ME
    disp(' ')
    disp('Case 13: param(6) > param(7)')
    disp(['t: ',num2str(t)])
    disp(['y: ',num2str(y)])
    disp(['param: ',num2str(param)])
    disp(' ')
    disp(ME.message)
    disp(' ')
    disp('Error log checked!')
    disp(' ')
end
% ----------------------------------------------------------- 

% Case 11: valid input
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 0.5 4 5]; % parameters vector
 
dy = rhs_SIRG(t,y,param);

disp(' ')
disp('Case 7: valid input')
disp(['t :',num2str(t)])
disp(['y: ',num2str(y)])
disp(['param: ',num2str(param)])
disp(' ')
disp(['dy: ',num2str(dy')])
disp(' ')
disp('Valid input checked!')
disp(' ')
% ----------------------------------------------------------- 
