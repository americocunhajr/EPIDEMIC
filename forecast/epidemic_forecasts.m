%=======================================================================%
%                                                                       %
%            EPIDEMIC - Epidemiology Educational Code                   %
%                       www.EpidemicCode.org                            %
% --------------------------------------------------------------------- %
%                          epidemic_forecast.m                          %
% --------------------------------------------------------------------- %
%                                                                       %
%                     - CASES AND DEATHS FORECASTS -                    %
%                                                                       %
% This is the main file to generate the forecast graphs of accumulated  %
% cases and accumulated deaths from an epidemic.                        %
%                                                                       %
% The purpose of this algorithm is to present the number of cases and   %
% deaths over time, with a 5-day forecast ahead determined by linear    %
% regression on the logarithmic scale of the number of cases and deaths.%
% The 95% confidence interval is also shown.                            %
%                                                                       %
% Note: In order to forecast the next 5 days, the last 5 days are       %
% considered.                                                           %
%                                                                       %
% You will need the 'cases-brazil-states.csv' file found in             %
% https://github.com/wcota/covid19br/                                   %
%                                                                       %
%                                                                       %
%                          Leonardo de la Roca                          %
%                    delaroca@protonmail.com@gmail.com                  %
%                                                                       %
%                                                                       %
%         [ ] Working                                                   %
% Status: [ ] Not working                                               %
%         [x] Experimental                                              %
%                                                                       %
% Last Update [17/06/2020]                                              %
%=======================================================================%


clc;
clear all;
close all;

%% Organizing country death and case data
%========================================================================

% Insert the last data update date, in the format DD/MM/AAAA
% -----------------------------------------------------------------------
date = '17/06/2020';
% -----------------------------------------------------------------------


% Reading the data file (must be in the same directory)
% -----------------------------------------------------------------------
all_data = readtable('cases-brazil-states.csv');
data     = table2cell(all_data);
% -----------------------------------------------------------------------


% Defining country as the sum of data for all its federal states
% -----------------------------------------------------------------------
country = 'Brazil';
states  = {'RO' 'AC' 'AM' 'RR' 'PA' 'AP' 'TO' 'MA' 'PI' 'CE' 'RN' 'PB'...
           'PE' 'AL' 'SE' 'BA' 'MG' 'ES' 'RJ' 'SP' 'PR' 'SC' 'RS' 'MS'...
           'MT' 'GO' 'DF'};
% -----------------------------------------------------------------------


% Checking the state data size
% -----------------------------------------------------------------------
for i = 1:length(states)
        location = data(find(strcmp([all_data.state], states(1,i))),:);
   maxcases(1,i) = length(cell2mat(location(:,8)));
  maxdeaths(1,i) = length(cell2mat(location(:,6)));
end
% -----------------------------------------------------------------------


% Collecting data on total cases and deaths for each state
% -----------------------------------------------------------------------
cases_states  = zeros(length(states),max(maxcases));
deaths_states = zeros(length(states),max(maxdeaths));

for i = 1:length(states)
            location = data(find(strcmp([all_data.state], states(1,i))),:);
   cases_states(i,:) = [zeros(1,max(maxcases)-maxcases(1,i)),nonzeros(cell2mat(location(:,8)))'];
  deaths_states(i,:) = [zeros(1,max(maxdeaths)-maxdeaths(1,i)),cell2mat(location(:,6))'];
end
% -----------------------------------------------------------------------


% Consolidating data on total cases and deaths for the country
% -----------------------------------------------------------------------
cases_country  = zeros(1,length(cases_states(1,:)));
deaths_country = zeros(1,length(deaths_states(1,:)));

for i = 1:length(states)
    cases_country  = cases_country+cases_states(i,:);
    deaths_country = deaths_country+deaths_states(i,:);
end
cases  = cases_country;
deaths = deaths_country;

%========================================================================


%% Plot the forecast of cases by time 
%========================================================================

% Defaults: Adjust days and dates
%-------------------------------------------------------------------------
date = [date(1,1:2),'-',date(1,4:5),'-',date(1,7:10)];
days = length(cases);
day  = str2num(date(1,1:2));
%-------------------------------------------------------------------------

% String for days ahead
% Make sure that, given today, the program gives the days ahead without 
% end of month problems like "30/05, 32/05, 34/05, ..."
%-------------------------------------------------------------------------
Datestring = date;
formatIn   = 'dd-mm-yyyy';

 ND = datenum(Datestring,formatIn)- 693960+1;
ND3 = ND+2;
ND5 = ND+4;

NextDay  = datetime(ND,'ConvertFrom','excel');
NextDay3 = datetime(ND3,'ConvertFrom','excel');
NextDay5 = datetime(ND5,'ConvertFrom','excel');

NextDay.Format  = 'dd-mm-yyyy';
NextDay3.Format = 'dd-mm-yyyy';
NextDay5.Format = 'dd-mm-yyyy';

str1 = datestr(NextDay,'dd-mm-yyyy');
str3 = datestr(NextDay3,'dd-mm-yyyy');
str5 = datestr(NextDay5,'dd-mm-yyyy');

LINE_DATE = [str1(1,1:2),'/',str1(1,4:5),'/',str1(1,7:10)];
       d1 = [str1(1,1:2),'/',str1(1,4:5)];
       d3 = [str3(1,1:2),'/',str3(1,4:5)];
       d5 = [str5(1,1:2),'/',str5(1,4:5)];
%-------------------------------------------------------------------------

% It has as input the number of cases over time, in the form
% cases = [211, 334, 467, 535, ... ]; 
%-------------------------------------------------------------------------
Datestring = date;
  formatIn = 'dd-mm-yyyy';
     final = datenum(Datestring,formatIn)- 693960;
     first = final-days;

         t = datetime(first:7:final,'ConvertFrom','excel');
  t.Format = 'dd-mm-yyyy';
       str = datestr(t,'dd/mm/yy');
%-------------------------------------------------------------------------


% Vector of days, one by one for the number of cases.
%-------------------------------------------------------------------------
days = sparse(1,length(cases));

for i = 1:length(cases)
    days(1,i) = i;
end
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
% 5 DAYS OF FORECAST
%-------------------------------------------------------------------------
% STEPS TO FORECAST:
%
% 1 - Plot the log points (#cases) vs days and take the last 5 days as a 
% sample
% 
% 2 - Find the best curve that fits those days, by linear regression
% (least squares method). At the same time as the 95% confidence interval 
% is discovered.
%
% 3 - With the regression and the confidence interval in hand, extrapolate
% these points to the next few days.
%-------------------------------------------------------------------------

% Take the last 5 days of the data as a sample
% Note: "5s" refers to the last 5 days taken as a sample
%-------------------------------------------------------------------------
cases5s = sparse(1,5);
days5s  = sparse(1,5);

for i = 0:4
    cases5s(1,i+1) = cases(1,length(cases)-4+i);
     days5s(1,i+1) = length(cases)-4+i;
end
%-------------------------------------------------------------------------


% Linear regression of log points (cases) vs days of the sample (last 5 days)
%------------------------------------------------------------------------
[coeffs5s,S_5s] = polyfit(days5s,log10(cases5s),1);
      fitobject = fit(days5s',log10(cases5s)','poly1');
%-------------------------------------------------------------------------


% 5-day prediction
% Note: "5f" refers to the 5-day forecast
%-------------------------------------------------------------------------
cases5f = sparse(1,5);
days5f  = sparse(1,5);

for i = 1:5
    days5f(1,i) = length(cases)+i;
end
cases5f = polyval(coeffs5s,days5f);
%-------------------------------------------------------------------------


% Reliability Interval Points
%-------------------------------------------------------------------------
ci = predint(fitobject,days5f)';

lowerCI_cases5f = ci(1,:);
upperCI_cases5f = ci(2,:);
%-------------------------------------------------------------------------


% Chart configuration
%-------------------------------------------------------------------------
figure

% Plot command notifications points
set(gca, 'YScale', 'linear')
plot(days,cases,'b','LineWidth',2);
hold on
c = scatter(days,cases,'r','LineWidth',2);

% Titles configuration
set(gca,'FontSize',12)
title({'Forecasting the progress of the epidemic (number of cases)',[country, ', ',date]},'FontSize',16);
ylabel('Total cases','FontSize',14)
hold on

% Plot command forecasts points

% Reliability Interval
pp   = fill([days5f fliplr(days5f)], [10.^lowerCI_cases5f fliplr(10.^upperCI_cases5f)], [0.8 0.8 0.8],'LineStyle','none');

% Forecasts points
plot(days5f,10.^(cases5f),'k','LineWidth',2);
hold on
b    = scatter(days5f,10.^(cases5f),'filled','k');
hold on
aaa  = scatter(1,1,1,[1 1 1]);
bbb  = scatter(1,1,1,[1 1 1]);
ccc  = scatter(1,1,1,[1 1 1]);

% Dotted line between notifications and forecasts
scat = scatter(ones(1,70)*days5f(1,1),...
               0:...
               (10.^(upperCI_cases5f(1,5)) + 5000)/69:...
               10.^(upperCI_cases5f(1,5)) + 5000,...
               10,'filled','k');
scat.MarkerFaceAlpha = 0.2; 

txxt = text(days5f(1,1)-1.5,0.2*10.^(cases5f(1,5)),...
            LINE_DATE,'FontSize',14,'Color',[0.6 0.6 0.6])
set(txxt,'Rotation',90);

% Legend configuration
lgd = legend([c b aaa bbb ccc pp],'Notifications','Forecasts: ',...
    [d1,': between ',num2str(round(10.^(lowerCI_cases5f(1,1)))),' and ', num2str(round(10.^(upperCI_cases5f(1,1)))),' ','cases'],...
    [d3,': between ',num2str(round(10.^(lowerCI_cases5f(1,3)))),' and ', num2str(round(10.^(upperCI_cases5f(1,3)))),' ','cases'],...
    [d5,': between ',num2str(round(10.^(lowerCI_cases5f(1,5)))),' and ', num2str(round(10.^(upperCI_cases5f(1,5)))),' ','cases'],...
    '95% probability','Location','northwest','Orientation','vertical');
lgd.FontSize = 14;
grid
ylim([0 10.^(upperCI_cases5f(1,5))+4000])
set(gca,'ytick',[floor(0:(10.^(upperCI_cases5f(1,5))+4000)/8:10.^(upperCI_cases5f(1,5))+4000)],'yticklabel',floor(0:(10.^(upperCI_cases5f(1,5))+4000)/8:10.^(upperCI_cases5f(1,5))+4000));
set(gca,'xtick',[0:7:length(days)],'xticklabel',str,'XTickLabelRotation',-45)
set(gcf, 'Position',  [100, 100, 1000, 700])
%-------------------------------------------------------------------------


% Saving the chart
%-------------------------------------------------------------------------
% print(figure(1) ,['forecast-cases','.png',],'-dpng','-r300');
%-------------------------------------------------------------------------

%========================================================================


%% Plot the forecast of deaths by time 
%========================================================================

% Defaults: Adjust days and dates
%-------------------------------------------------------------------------

date = [date(1,1:2),'-',date(1,4:5),'-',date(1,7:10)];
days = length(deaths);
day  = str2num(date(1,1:2));

% String for days ahead
% Make sure that, given today, the program gives the days ahead without 
% end of month problems like "30/05, 32/05, 34/05, ..."
%-------------------------------------------------------------------------
DateString = date;
formatIn   = 'dd-mm-yyyy';
  
 ND = datenum(DateString,formatIn)- 693960+1;
ND3 = ND+2;
ND5 = ND+4;

NextDay  = datetime(ND,'ConvertFrom','excel');
NextDay3 = datetime(ND3,'ConvertFrom','excel');
NextDay5 = datetime(ND5,'ConvertFrom','excel');

NextDay.Format  = 'dd-mm-yyyy';
NextDay3.Format = 'dd-mm-yyyy';
NextDay5.Format = 'dd-mm-yyyy';

str1 = datestr(NextDay,'dd-mm-yyyy');
str3 = datestr(NextDay3,'dd-mm-yyyy');
str5 = datestr(NextDay5,'dd-mm-yyyy');

LINE_DATE = [str1(1,1:2),'/',str1(1,4:5),'/',str1(1,7:10)];
       d1 = [str1(1,1:2),'/',str1(1,4:5)];
       d3 = [str3(1,1:2),'/',str3(1,4:5)];
       d5 = [str5(1,1:2),'/',str5(1,4:5)];
%-------------------------------------------------------------------------

% It has as input the number of deaths over time, in the form
% deaths = [211, 334, 467, 535, ... ]; 
%-------------------------------------------------------------------------
DateString = date;
formatIn   = 'dd-mm-yyyy';
     final = datenum(DateString,formatIn)- 693960;
     first = final-days;

         t = datetime(first:7:final,'ConvertFrom','excel');
  t.Format = 'dd-mm-yyyy';
       str = datestr(t,'dd/mm/yy');
%-------------------------------------------------------------------------


% Vector of days, one by one for the number of deaths.
%-------------------------------------------------------------------------
days = sparse(1,length(deaths));

for i = 1:length(deaths)
    days(1,i) = i;
end
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
% 5 DAYS OF FORECAST
%-------------------------------------------------------------------------
% STEPS TO FORECAST:
%
% 1 - Plot the log points (#deaths) vs days and take the last 5 days as a 
% sample
% 
% 2 - Find the best curve that fits those days, by linear regression
% (least squares method). At the same time as the 95% confidence interval 
% is discovered.
%
% 3 - With the regression and the confidence interval in hand, extrapolate
% these points to the next few days.
%-------------------------------------------------------------------------

% Take the last 5 days of the data as a sample
% Note: "5s" refers to the last 5 days taken as a sample
%-------------------------------------------------------------------------
deaths5s = sparse(1,5);
days5s   = sparse(1,5);

for i = 0:4
    deaths5s(1,i+1) = deaths(1,length(deaths)-4+i);
      days5s(1,i+1) = length(deaths)-4+i;
end
%-------------------------------------------------------------------------


% Linear regression of log points (deaths) vs days of the sample (last 5 days)
%-------------------------------------------------------------------------
[coeffs5s,S_5s] = polyfit(days5s,log10(deaths5s),1);
      fitobject = fit(days5s',log10(deaths5s)','poly1');
%-------------------------------------------------------------------------


% 5-day prediction
% Note: "5f" refers to the 5-day forecast
%-------------------------------------------------------------------------
deaths5f = sparse(1,5);
days5f   = sparse(1,5);

for i = 1:5
    days5f(1,i)= length(deaths)+i;
end
deaths5f = polyval(coeffs5s,days5f);
%-------------------------------------------------------------------------


% Reliability Interval Points
%-------------------------------------------------------------------------
ci = predint(fitobject,days5f)';

lowerCI_deaths5f = ci(1,:);
upperCI_deaths5f = ci(2,:);
%-------------------------------------------------------------------------

% Chart configuration
%-------------------------------------------------------------------------
figure

% Plot command notifications points
set(gca, 'YScale', 'linear')
plot(days,deaths,'b','LineWidth',2);
hold on
c = scatter(days,deaths,'r','LineWidth',2);

% Titles configuration
set(gca,'FontSize',12)
title({'Forecasting the progress of the epidemic (number of deaths)',[country, ', ',date]},'FontSize',16);
ylabel('Total deaths','FontSize',14)
hold on

% Plot command forecasts points

% Reliability Interval
pp   = fill([days5f fliplr(days5f)], [10.^lowerCI_deaths5f fliplr(10.^upperCI_deaths5f)], [0.8 0.8 0.8],'LineStyle','none');

% Forecasts points
plot(days5f,10.^(deaths5f),'k','LineWidth',2);
hold on
b    = scatter(days5f,10.^(deaths5f),'filled','k');
hold on
aaa  = scatter(1,1,1,[1 1 1]);
bbb  = scatter(1,1,1,[1 1 1]);
ccc  = scatter(1,1,1,[1 1 1]);

% Dotted line between notifications and forecasts
scat = scatter(ones(1,70)*days5f(1,1),...
               0:...
               (10.^(upperCI_deaths5f(1,5)) + 500)/69:...
               10.^(upperCI_deaths5f(1,5)) + 500,...
               10,'filled','k');
scat.MarkerFaceAlpha = 0.2; 

txxt = text(days5f(1,1)-1.5,0.2*10.^(deaths5f(1,5)),...
            LINE_DATE,'FontSize',14,'Color',[0.6 0.6 0.6])
set(txxt,'Rotation',90);

% Legend configuration
lgd = legend([c b aaa bbb ccc pp],'Notifications','Forecasts: ',...
    [d1,': between ',num2str(round(10.^(lowerCI_deaths5f(1,1)))),' and ', num2str(round(10.^(upperCI_deaths5f(1,1)))),' ','deaths'],...
    [d3,': between ',num2str(round(10.^(lowerCI_deaths5f(1,3)))),' and ', num2str(round(10.^(upperCI_deaths5f(1,3)))),' ','deaths'],...
    [d5,': between ',num2str(round(10.^(lowerCI_deaths5f(1,5)))),' and ', num2str(round(10.^(upperCI_deaths5f(1,5)))),' ','deaths'],...
    '95% probability','Location','northwest','Orientation','vertical');
lgd.FontSize = 14;
grid
ylim([0 10.^(upperCI_deaths5f(1,5))+300])
set(gca,'ytick',[floor(0:(10.^(upperCI_deaths5f(1,5))+300)/8:10.^(upperCI_deaths5f(1,5))+300)],'yticklabel',floor(0:(10.^(upperCI_deaths5f(1,5))+300)/8:10.^(upperCI_deaths5f(1,5))+300));
set(gca,'xtick',[0:7:length(days)],'xticklabel',str,'XTickLabelRotation',-45)
set(gcf, 'Position',  [100, 100, 1000, 700])
%-------------------------------------------------------------------------


% Saving the chart
%-------------------------------------------------------------------------
% print(figure(2) ,['forecast-deaths','.png',],'-dpng','-r300');
%-------------------------------------------------------------------------

%========================================================================