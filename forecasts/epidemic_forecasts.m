% -----------------------------------------------------------
% EPIDEMIC - Epidemiology Educational Code
% www.EpidemicCode.org
% -----------------------------------------------------------
% Forecasts: epidemic_forecasts.m

% This is the main file to generate the forecast graphs of accumulated    
% cases and accumulated deaths from an epidemic.                          
%                                                                         
% The purpose of this algorithm is to present the number of cases and     
% deaths over time, with a 5-day forecast ahead determined by linear      
% regression on the logarithmic scale of the number of cases and deaths.  
% The 95% confidence interval is also shown.                              
%                                                                         
% Note: In order to forecast the next 5 days, the last 5 days are         
% considered.                                                             
%                                                                         
% You will need the 'cases-brazil-states.csv' file found in               
% https://github.com/wcota/covid19br/                                     
%
% Inputs:
%   cases-brazil-states.csv: wcota data file           - .csv file
%     -> 1st collumn:  date field                                                                       
%     -> 3rd collumn:  state field                                                                       
%     -> 6th collumn:  totalDeaths field                                                                       
%     -> 8th collumn:  totalCases field                                                                       
%     
% Outputs:                                                               
%   forecasts-cases: forecasts of the cases            - .png file           
%   forecasts-deaths: forecasts of the deaths          - .png file           

% ----------------------------------------------------------------------- 
% programmers: Leonardo de la Roca                                        
%              Julio Basilio                                              
%                                                                         
% number of lines: 120                                                   
% last Update: Jan 18, 2021                                               
% ----------------------------------------------------------------------- 

clc
clear
close all


% Forecasts graphics
% -------------------------------------------------------------------------
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
disp(' +++++++++++++++++  OBJECTIVE  +++++++++++++++++')
disp(' -----------------------------------------------')
disp(' To present the number of cases and deaths      ')
disp(' over time, with a 5-day forecast ahead         ')
disp(' determined by linear regression on the         ')
disp(' logarithmic scale of the number of cases       ')
disp(' and deaths, with a 95% confidence interval.    ')
disp(' -----------------------------------------------')
disp(' ')
disp(' -----------------------------------------------')
disp(' ++++++++  EPIDEMIC FORECASTS GRAPHICS  ++++++++')
disp(' -----------------------------------------------')
disp(' Forecasting the progress of the epidemic:      ')
disp(' 1) Number acumulated of cases)                 ')
disp(' 2) Number acumulated of deaths)                ')
disp(' -----------------------------------------------')
% -------------------------------------------------------------------------

%% Organizing  death and case data
%==========================================================================

% Insert the last data update date, in the format MM/DD/AAAA
% -------------------------------------------------------------------------
up_date = '04/07/2020';
% -------------------------------------------------------------------------

% Reading the data file
%(After downloading, save this file in the same directory as the code)
% -------------------------------------------------------------------------
A = fileread('cases-brazil-states.csv');
B = strsplit(A,'\n');

for i = 1:length(B(1,:))
    all_data(i,:) = strsplit(B{1,i},',','CollapseDelimiters',false);
end

if ~strcmp(all_data(1,1),'date')
   error('Warning: dates must be in the 1st column of the file')
elseif ~strcmp(all_data(1,3),'state')
   error('Warning: states names must be in the 3rd column of the file')
elseif ~strcmp(all_data(1,6),'totalDeaths')
   error('Warning: total deaths must be in the 6th column of the file')
elseif ~strcmp(all_data(1,8),'totalCases')
   error('Warning: total cases must be in the 8th column of the file')
end 
 
% -------------------------------------------------------------------------

% Defining country as the sum of data for all its federal states
% -------------------------------------------------------------------------
country = 'Brazil';
states  = {'RO' 'AC' 'AM' 'RR' 'PA' 'AP' 'TO' 'MA' 'PI'...
           'CE' 'RN' 'PB' 'PE' 'AL' 'SE' 'BA' 'MG' 'ES'...
           'RJ' 'SP' 'PR' 'SC' 'RS' 'MS' 'MT' 'GO' 'DF'};
% -------------------------------------------------------------------------

% Checking the state data size
% -------------------------------------------------------------------------
for i = 1:length(states)
        location = all_data(find(strcmp(all_data(:,3),states(1,i))),:);
   maxcases(1,i) = length(cellfun(@str2double,(location(:,8))));
  maxdeaths(1,i) = length(cellfun(@str2double,(location(:,6))));
end
% -------------------------------------------------------------------------

% Collecting data on total cases and deaths for each state
% -------------------------------------------------------------------------
cases_states  = zeros(length(states),max(maxcases) );
deaths_states = zeros(length(states),max(maxdeaths));

for i = 1:length(states)
           location = all_data(find(strcmp(all_data(:,3),states(1,i))),:);
  
  cases_states(i,:) = [zeros(1,max(maxcases)-maxcases(1,i)),...
                       nonzeros(cellfun(@str2double,location(:,8)))'];
 
 deaths_states(i,:) = [zeros(1,max(maxdeaths)-maxdeaths(1,i)),...
                       cellfun(@str2double,location(:,6))'];
end
% -------------------------------------------------------------------------

% Consolidating data on total cases and deaths for the country
% -------------------------------------------------------------------------
cases_country  = zeros(1,length(cases_states (1,:)));
deaths_country = zeros(1,length(deaths_states(1,:)));

for i = 1:length(states)
     cases_country = cases_country  + cases_states (i,:);
    deaths_country = deaths_country + deaths_states(i,:);
end

cases  = cases_country ;
deaths = deaths_country;
% -------------------------------------------------------------------------
%==========================================================================

%% Plotting the forecast of cases/deaths by time 
%==========================================================================
for init = 1:2

    % Cleaning up reused variables inside the loop
    clearvars -except up_date init cases country deaths all_data ...
                      cases_country deaths_country cases_states ...
                      deaths_states location maxcases maxdeaths states 

    % Data loop for plotting cases and then deaths 
    if (init == 1); data = cases ; info = 'cases'  ; end
    if (init == 2); data = deaths; info = 'deaths' ; end

    % Defaults: Adjust days and dates
    %----------------------------------------------------------------------
    date = [up_date(1,1:2),'-',up_date(1,4:5),'-',up_date(1,7:10)];
    days = length (data);
    day  = str2num(up_date(1,1:2));
    %----------------------------------------------------------------------

    % Setting string for days ahead (Transforming the date to strings)
    % This make sure that, given the day, the program gives the days ahead 
    % without end of month problems like "30/05, 32/05, 34/05, ..."
    %----------------------------------------------------------------------
    Datestring = date;
    formatIn   = 'mm-dd-yyyy';

     ND = datenum(Datestring,formatIn)+1;
    ND3 = ND+2;
    ND5 = ND+4;
    %----------------------------------------------------------------------
    
    % Setting to include in the legend
    %----------------------------------------------------------------------
    str1 = datestr(ND ,'mm-dd-yyyy');
    str3 = datestr(ND3,'mm-dd-yyyy');
    str5 = datestr(ND5,'mm-dd-yyyy');
    
    LINE_DATE = [str1(1,1:2),'/',str1(1,4:5),'/',str1(1,7:10)];
           d1 = [str1(1,1:2),'/',str1(1,4:5)];
           d3 = [str3(1,1:2),'/',str3(1,4:5)];
           d5 = [str5(1,1:2),'/',str5(1,4:5)];
    %----------------------------------------------------------------------

    % Setting to include in the X-axis
    %----------------------------------------------------------------------
    Datestring = date;
    formatIn   = 'mm-dd-yyyy';
    final = datenum(Datestring,formatIn);
    first = final - days;
      str = datestr(first:21:final,'mm/dd/yy');
    %----------------------------------------------------------------------

    % Vector of days, one by one for the number of cases/deaths.
    %----------------------------------------------------------------------
    days = sparse(1,length(data));

    for i = 1:length(data)
        days(1,i) = i;
    end
    %----------------------------------------------------------------------
    
    %----------------------------------------------------------------------
    % 5 DAYS OF FORECAST
    %----------------------------------------------------------------------
    % STEPS TO FORECAST:
    %
    % 1 - Plot the log points (cases or deaths) vs days and take the  
    %     last 5 days as a sample
    % 
    % 2 - Find the best curve that fits those days, by linear regression
    %     (least squares method). At the same time as the 95% confidence 
    %     interval is discovered.
    %
    % 3 - With the regression and the confidence interval in hand, 
    %     extrapolate these points to the next few days.
    %----------------------------------------------------------------------

    % Take the last 5 days of the data as a sample
    % Note: "5s" refers to the last 5 days taken as a sample
    %----------------------------------------------------------------------
    data5s = sparse(1,5);
    days5s  = sparse(1,5);

    for i = 0:4
        data5s(1,i+1) = data(1,length(data)-4+i);
        days5s(1,i+1) = length(data)-4+i;
    end
    %----------------------------------------------------------------------

    % Linear regression of log points vs days of the sample (last 5 days)
    %----------------------------------------------------------------------
    [coeffs5s,S_5s] = polyfit(days5s,log10(data5s),1);
    %----------------------------------------------------------------------

    % 5-day prediction
    % Note: "5f" refers to the 5-day forecast
    %----------------------------------------------------------------------
    data5f = sparse(1,5);
    days5f = sparse(1,5);

    for i = 1:5
        days5f(1,i) = length(data) + i;
    end
    
    data5f = polyval(coeffs5s,days5f);
    %----------------------------------------------------------------------

    % Confidence band calculation
    %----------------------------------------------------------------------
    % Method 1
    %----------------------------------------------------------------------
    % Fitted line
    datafit = coeffs5s(1,2) + coeffs5s(1,1)*days5s; 
    % Variance estimation
    N = length(days5s);
    sigma2  = sum((log10(data5s) - datafit).^2)/(N-1);
    % Denominator
    den = N*sum((days5s-mean(days5s)).^2);
    
    for i = 1:N; 
        % Numerator
        num = sum((days5s-days5f(1,i)).^2);        
        % Variance square correction
        ksi2(1,i) = sigma2*((num/den)+1);
    end
    % Variance correction
    ksi = sqrt(ksi2);

    % Confidence band
    upperCB = data5f + 1.96*ksi;
    lowerCB = data5f - 1.96*ksi;
    %----------------------------------------------------------------------

    % Method 2 (This method uses a direct command)
    %----------------------------------------------------------------------
    % To run on MATLAB disable the commands below
    %pkg install -forge optim
    %pkg load optim 

    %[deaths5f,dy]  = polyconf(coeffs5s,days5f,S_5s);
    %upperCB_data5f = data5f + dy;
    %lowerCB_data5f = data5f - dy;
    %----------------------------------------------------------------------

    % Chart configuration
    %----------------------------------------------------------------------
    figure

    % Plot command notifications points
     set(gca ,'YScale','linear')
    plot(days,data,'b','LineWidth',2);
    hold on
    c = scatter(days,data,'r','LineWidth',2);

    % Titles configuration
      set(gca,'FontSize',12)
    title({['Forecasting the progress of the epidemic '...
            '(number of ',info,')'],...
            [country, ', ',up_date]},...
            'FontSize',16);
    ylabel({['Total ',info]},'FontSize',14)
    hold on

    % Confidence band
    CB = fill([days5f fliplr(days5f)],...
              [10.^lowerCB fliplr(10.^upperCB)],...
              [0.8 0.8 0.8],...
              'LineStyle','none');

    % Forecasts points
    plot(days5f,10.^(data5f),'k','LineWidth',2);
    hold on
    b = scatter(days5f,10.^(data5f),'k','filled');
    hold on

    % Legend configuration
    aaa  = scatter(1,1,1,[1 1 1]);
    bbb  = scatter(1,1,1,[1 1 1]);
    ccc  = scatter(1,1,1,[1 1 1]);
    lgd  = legend([c b aaa bbb ccc CB],...
                  'Notifications',...
                  'Forecasts: ',...
                  [d1,': between ',num2str(round(10.^(lowerCB(1,1)))),...
                                  ' and ',...
                                   num2str(round(10.^(upperCB(1,1)))),...
                  ' ',info],...
                  [d3,': between ',num2str(round(10.^(lowerCB(1,3)))),...
                                  ' and ',...
                                   num2str(round(10.^(upperCB(1,3)))),...
                  ' ',info],...
                  [d5,': between ',num2str(round(10.^(lowerCB(1,5)))),...
                                  ' and ',...
                                   num2str(round(10.^(upperCB(1,5)))),...
                  ' ',info],...
                  '95% probability',...
                  'Location','northwest','Orientation','vertical');
    set(lgd,'FontSize',14);

    % Dotted line between notifications and forecasts
    scat = scatter(ones(1,70)*days5f(1,1),...
                   0:...
                   (10^(upperCB(1,5))*1.03)/69:...
                    10^(upperCB(1,5))*1.03,...
                    10,[0.6 0.6 0.6],'filled');
                
    txxt = text(days5f(1,1)-1.5      ,...
                0.2*10.^(data5f(1,5)),...
                LINE_DATE            ,...
                'FontSize',14,...
                'Color',[0.6 0.6 0.6]);
    set(txxt,'Rotation',90);

    % Scale configuration
    grid
    
    ylim([0 10.^(upperCB(1,5))*1.03])
    set(gca,'ytick',...
            floor(0:(10.^(upperCB(1,5))*1.03)/8:10^(upperCB(1,5))*1.03),...
            'yticklabel',...
            floor(0:(10.^(upperCB(1,5))*1.03)/8:10^(upperCB(1,5))*1.03));
    
    set(gca,'xtick',0:21:length(days),'xticklabel',str);
    
    set(gcf,'Position',[100, 100, 1000, 700]);
    %----------------------------------------------------------------------

end

% Saving the chart
%-------------------------------------------------------------------------
 print(figure(1) ,['forecasts-cases' ,'.png',],'-dpng','-r300');
 
 print(figure(2) ,['forecasts-deaths','.png',],'-dpng','-r300');
%-------------------------------------------------------------------------
