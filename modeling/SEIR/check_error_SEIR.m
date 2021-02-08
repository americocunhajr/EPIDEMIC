% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Modeling: check_error_SEIR.m
%
% This is a main file for check the rhs_SEIR.m 
% function constraints
%
%
% Inputs:
%   t: time                       - double
%   y: state vector               - double array (5x1)
%   param: parameters vector      - double array (?x1)
%   rhs_SEIR: SEIR equations file   - .m function file
%
% Output:
%   log                           - interface messages
% -----------------------------------------------------------
% programmers: Diego M. S. Lopes
%	           Michel Tosin
%
% number of lines: 124
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
disp('   by Bruna Pavlack et al.                      ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' -----------------------------------------------')
disp(' ++++++++++++++ rhs_SEIR checking ++++++++++++++')
% -----------------------------------------------------------

% Case 1: length(param) < 4 
% -----------------------------------------------------------  
t = 1;                  % time
y = [999 0 1 0 1];      % state vector
param = [1000 0.5 0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
catch ME
    disp(' ')
    disp('Case 1: length(param) < 4')
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

% Case 2: length(param) > 4
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
catch ME
    disp(' ')
    disp('Case 2: length(param) > 4')
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
param = [1000.25 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
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
param = [-1000 0.5 0.5 0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
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
param = [1000 -0.5 0.5 0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
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
param = [1000 0.5 -0.5 0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
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
param = [1000 0.5 0.5 -0.5]; % parameters vector

try  
    rhs_SEIR(t,y,param)
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

% Case 8: valid input
% -----------------------------------------------------------  
param = [1000 0.5 0.5 0.5]; % parameters vector
 
dy = rhs_SEIR(t,y,param);

disp(' ')
disp('Case 8: valid input')
disp(['t :',num2str(t)])
disp(['y: ',num2str(y)])
disp(['param: ',num2str(param)])
disp(' ')
disp(['dy: ',num2str(dy')])
disp(' ')
disp('Valid input checked!')
disp(' ')
% ----------------------------------------------------------- 
