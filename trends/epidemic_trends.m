% --------------------------------------------------------------------- %
% EPIDEMIC - Epidemiology Educational Code                              %
% www.EpidemicCode.org                                                  %
% --------------------------------------------------------------------- %
%                         epidemic_trends.m                             %
% --------------------------------------------------------------------- %
% This algorithm generates graphs on the numbers of cases and deaths    %
% by epidemic in the countries of interest.                             % 
%                                                                       %
% The series of graphs contains in absolute values                      %
% and per million inhabitants                                           %
% - number of cases in relation to the time since X cases               %
% - number of deaths over time since X deaths                           %
% - number of new cases per week in relation to the time since X cases  %
% - number of new deaths per week in relation to the time since X deaths%
% - number of new cases per week in relation to total cases             %
% - number of new deaths per week in relation to total deaths           %
%                                                                       %
% You will need the file 'owid-covid-data.csv' found in                 %
% https://ourworldindata.org/coronavirus-source-data                    %
% --------------------------------------------------------------------- %                                                                     %
% programmers: Malú Grave                                               %
%                                                                       %
% last Update [16/07/2020]                                              %
%=======================================================================%

clc;
clear all;
close all;

% Trends graphics
% -----------------------------------------------------------------------
disp(' ')
disp('================================================')
disp('   EPIDEMIC - Epidemiology Educational Code     ')
disp('   by E. Dantas, M. Grave, L. Roca, et al.      ')
disp('                                                ')
disp('   This is an easy to run educational toolkit   ')
disp('   for epidemiological analysis.                ')
disp('                                                ')
disp('   www.EpidemicCode.org                         ')
disp('================================================')
disp(' ')
disp(' -----------------------------------------------')
disp(' +++++++++  EPIDEMIC TRENDS GRAPHICS  +++++++++ ')
disp(' -----------------------------------------------')
disp(' 1) Acumulated deaths'                           )
disp(' 2) Acumulated cases'                            )
disp(' 3) Epidemic progress (number of deaths)'        )
disp(' 4) Epidemic progress (number of cases)'         )
disp(' 5) Weekly deaths'                               )
disp(' 6) Weekly cases'                                )
disp(' 7) Mortality of the epidemic'                   )
disp(' 8) Prevalence of the epidemic'                  )
disp(' 9) Weekly deaths per million'                   )
disp('10) Weekly incidence'                            )
disp(' -----------------------------------------------')
% -----------------------------------------------------------------------

% Reading the data file
%(After downloading, save this file in the same directory as the code)
% -----------------------------------------------------------------------
A = fileread('owid-covid-data.csv');
B = strsplit(A,'\n');

 for i = 1:length(B(1,:))
    all_data(i,:) = strsplit(B{1,i},',','CollapseDelimiters',false);
 end
 
data = [str2double(all_data(:, 4)),...
        str2double(all_data(:, 5)),...
        str2double(all_data(:, 6)),...
        str2double(all_data(:, 7)),...
        str2double(all_data(:, 8)),...
        str2double(all_data(:, 9)),...
        str2double(all_data(:,10)),...
        str2double(all_data(:,11))];
% -----------------------------------------------------------------------

% Running the loop command in the 14 countries studied
% -----------------------------------------------------------------------
for init = 1:1:14

    % Cleaning up reused variables inside the loop
    clearvars -except plot_type init all_data data name paises tot_deaths tot_cases

    % Order by countries that have more death
    if (init ==  6); country='Brazil'        ; color=[  0,  0,  0]/255; end
    if (init == 14); country='South Korea'   ; color=[ 69,169,  0]/255; end
    if (init == 10); country='Turkey'        ; color=[ 96,209,224]/255; end  
    if (init == 12); country='Peru'          ; color=[181,147, 87]/255; end
    if (init ==  9); country='Iran'          ; color=[255,130,113]/255; end
    if (init ==  8); country='Germany'       ; color=[209,227,105]/255; end
    if (init == 13); country='Chile'         ; color=[248,187,208]/255; end
    if (init ==  1); country='United States' ; color=[  0,104, 44]/255; end
    if (init ==  4); country='France'        ; color=[  0, 45,135]/255; end
    if (init ==  2); country='United Kingdom'; color=[135, 85, 30]/255; end
    if (init ==  3); country='Italy'         ; color=[203, 63, 23]/255; end
    if (init ==  5); country='Spain'         ; color=[191,171, 72]/255; end
    if (init ==  7); country='Belgium'       ; color=[236, 64,122]/255; end
    if (init == 11); country='Russia'        ; color=[102,102,102]/255; end

    % Collecting country data
    location = data(find(strcmp([all_data(:,2)], country)),1:8);
    
    % Defining the matrix with dates and the final day
    all_data_date = all_data(:,3);
    dates         = all_data_date(find(strcmp([all_data(:,2)],country)),:);
    end_time      = max(datenum(dates))-1;
    
    % Separating the data
    tot_cases  = location(:,1);
    new_cases  = location(:,2);
    tot_deaths = location(:,3);
    new_deaths = location(:,4);

    % Data per million
    tot_cases_pm  = location(:,5);
    new_cases_pm  = location(:,6);
    tot_deaths_pm = location(:,7); 
    new_deaths_pm = location(:,8);   
    
    % Consolidating new cases and deaths per week
    for i = 7:1:max(max(size(dates)))  
            new_cases7(i,1) = new_cases(i  ,1) + ...
                              new_cases(i-1,1) + ... 
                              new_cases(i-2,1) + ...
                              new_cases(i-3,1) + ...
                              new_cases(i-4,1) + ...
                              new_cases(i-5,1) + ...
                              new_cases(i-6,1);
                          
           new_deaths7(i,1) = new_deaths(i  ,1) + ...
                              new_deaths(i-1,1) + ...
                              new_deaths(i-2,1) + ...
                              new_deaths(i-3,1) + ...
                              new_deaths(i-4,1) + ...
                              new_deaths(i-5,1) + ...
                              new_deaths(i-6,1);
                          
         new_cases7_pm(i,1) = new_cases_pm(i  ,1) + ...
                              new_cases_pm(i-1,1) + ...
                              new_cases_pm(i-2,1) + ...
                              new_cases_pm(i-3,1) + ...
                              new_cases_pm(i-4,1) + ...
                              new_cases_pm(i-5,1) + ...
                              new_cases_pm(i-6,1);
                          
        new_deaths7_pm(i,1) = new_deaths_pm(i  ,1) + ...
                              new_deaths_pm(i-1,1) + ...
                              new_deaths_pm(i-2,1) + ...
                              new_deaths_pm(i-3,1) + ...
                              new_deaths_pm(i-4,1) + ...
                              new_deaths_pm(i-5,1) + ...
                              new_deaths_pm(i-6,1);
    end

    % Creating vectors from day zero from X deaths ('_deaths')
    % or from X cases ('_cases').
    % User sets zero day for cases or deaths
    X_deaths_pm = 1;
    X_cases_pm  = 10;
    X_deaths    = 100;
    X_cases     = 1000;

    % Relative to total deaths
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_deaths(i,1)   >= X_deaths)
            n = n + 1;
            tot_deaths_X (n,1) = tot_deaths (i,1);
            new_deaths_X (n,1) = new_deaths (i,1);
            new_deaths7_X(n,1) = new_deaths7(i,1);
        end
    end
    
    % Relative to total cases
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_cases(i,1)   >= X_cases)
            n = n + 1;
            tot_cases_X (n,1) = tot_cases (i,1);
            new_cases_X (n,1) = new_cases (i,1);
            new_cases7_X(n,1) = new_cases7(i,1);
        end
    end
    
    % Related deaths per million
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_cases_pm(i,1)  >= X_cases_pm)
            n = n + 1;
            tot_cases_pmX (n,1) = tot_cases_pm (i,1);
            new_cases_pmX (n,1) = new_cases_pm (i,1);
            new_cases7_pmX(n,1) = new_cases7_pm(i,1);
        end
    end
    
    % Related cases per million
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_deaths_pm(i,1)  >= X_deaths_pm)
            n = n + 1;
            tot_deaths_pmX (n,1) = tot_deaths_pm (i,1);
            new_deaths_pmX (n,1) = new_deaths_pm (i,1);
            new_deaths7_pmX(n,1) = new_deaths7_pm(i,1);
        end
    end
    
    % Basics graphics settings
   
    % Fonts
    font_title    = 10.5;
    font_labels   = 10;
    font_default  = 9; 
    font_location = 8;

    % X-axis size
    day_axis = 100;
    
    % Aligning the legend
    if strcmp(country,'Brazil'        ); country_leg='Brazil                 ' ; end
    if strcmp(country,'South Korea'   ); country_leg='South Korea      '       ; end
    if strcmp(country,'Turkey'        ); country_leg='Turkey               '   ; end
    if strcmp(country,'Peru'          ); country_leg='Peru                  '  ; end
    if strcmp(country,'Iran'          ); country_leg='Iran                    '; end
    if strcmp(country,'Germany'       ); country_leg='Germany           '      ; end
    if strcmp(country,'Chile'         ); country_leg='Chile                  ' ; end
    if strcmp(country,'United States' ); country_leg='United States    '       ; end
    if strcmp(country,'France'        ); country_leg='France               '   ; end
    if strcmp(country,'United Kingdom'); country_leg='United Kingdom'          ; end
    if strcmp(country,'Italy'         ); country_leg='Italy                   '; end
    if strcmp(country,'Spain'         ); country_leg='Spain                 '  ; end
    if strcmp(country,'Belgium'       ); country_leg='Belgium             '    ; end
    if strcmp(country,'Russia'        ); country_leg='Russia               '   ; end
    
    deaths_leg = ['',num2str(max(tot_deaths))];
    if size(num2str(max(tot_deaths)))<5; deaths_leg=['  '       ,num2str(max(tot_deaths))];end
    if size(num2str(max(tot_deaths)))<4; deaths_leg=['    '     ,num2str(max(tot_deaths))];end
    if size(num2str(max(tot_deaths)))<3; deaths_leg=['      '   ,num2str(max(tot_deaths))];end
    if size(num2str(max(tot_deaths)))<2; deaths_leg=['         ',num2str(max(tot_deaths))];end

    cases_leg = ['',num2str(max(tot_cases))];
    if size(num2str(max(tot_cases)))<7; cases_leg=['  '         ,num2str(max(tot_cases))];end
    if size(num2str(max(tot_cases)))<6; cases_leg=['    '       ,num2str(max(tot_cases))];end
    if size(num2str(max(tot_cases)))<5; cases_leg=['      '     ,num2str(max(tot_cases))];end
    if size(num2str(max(tot_cases)))<4; cases_leg=['         '  ,num2str(max(tot_cases))];end
    
    % Plot total deaths by time (zero day defined by deaths)
    figure (1);
    n    = max(max(size(tot_deaths_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_deaths_X,...
                    'DisplayName',[country_leg,'   ',deaths_leg,'  ','deaths'],...
                    'color',color,...
                    'LineWidth',1.25);
    hold on;
    text (n-1,tot_deaths_X(n,1),[' ',country_leg],...
          'FontSize',font_location,...
          'color',color,...
          'Clipping','on');

     % Plot total cases by time (day zero defined by cases)
     figure (2);
     n    = max(max(size(tot_cases_X)));
     days = 0:1:n-1;
     fig  = semilogy(days,tot_cases_X,...
                     'DisplayName',[country_leg,'   ',cases_leg,'  ','cases'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text (n-1,tot_cases_X(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot new deaths vs total deaths
     figure (3);
     n   = max(max(size(tot_deaths)));
     fig = loglog(tot_deaths,new_deaths7,...
                  'DisplayName',[country_leg,'   ',deaths_leg,'  ','deaths'],...
                  'color',color,...
                  'LineWidth',1.25);
     hold on;
     text (tot_deaths(n,1),new_deaths7(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot new cases vs total cases
     figure (4);
     n   = max(max(size(tot_cases)));
     fig = loglog(tot_cases,new_cases7,...
                   'DisplayName',[country_leg,'   ',cases_leg,'  ','cases'],...
                   'color',color,...
                   'LineWidth',1.25);
     hold on;
     text (tot_cases(n,1),new_cases7(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot new deaths by time (zero day defined by deaths)
     figure (5);
     n    = max(max(size(new_deaths_X)));
     days = 0:1:n-1;
     fig  = semilogy(days/7,new_deaths7_X,...
                     'DisplayName',[country_leg,'   ',deaths_leg,'  ','deaths'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text ((n-1)/7,new_deaths7_X(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot new cases by time (day zero defined by cases)
     figure (6);
     n    = max(max(size(new_cases_X)));
     days = 0:1:n-1;
     fig  = semilogy(days/7,new_cases7_X,...
                     'DisplayName',[country_leg,'   ',cases_leg,'  ','cases'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text ((n-1)/7,new_cases7_X(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot total deaths / million by time (zero day defined by deaths / million)
     figure (7);
     n    = max(max(size(tot_deaths_pmX)));
     days = 0:1:n-1;
     fig  = semilogy(days,tot_deaths_pmX,...
                     'DisplayName',[country_leg,'   ',deaths_leg,'  ','deaths'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text (n-1,tot_deaths_pmX(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot total cases / million by time (day zero defined by cases / million)
     figure (8);
     n    = max(max(size(tot_cases_pmX)));
     days = 0:1:n-1;
     fig  = semilogy(days,tot_cases_pmX,...
                     'DisplayName',[country_leg,'   ',cases_leg,'  ','cases'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text (n-1,tot_cases_pmX(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
  
     % Plot new deaths / million by time (zero day defined by deaths / million)
     figure (9);
     n    = max(max(size(new_deaths_pmX)));
     days = 0:1:n-1;
     fig  = semilogy(days/7,new_deaths7_pmX,...
                     'DisplayName',[country_leg,'   ',deaths_leg,'  ','deaths'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text ((n-1)/7,new_deaths7_pmX(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');
 
     % Plot new cases / million by time (day zero defined by cases / million)
     figure (10);
     n    = max(max(size(new_cases_pmX)));
     days = 0:1:n-1;
     fig  = semilogy(days/7,new_cases7_pmX,...
                     'DisplayName',[country_leg,'   ',cases_leg,'  ','cases'],...
                     'color',color,...
                     'LineWidth',1.25);
     hold on;
     text ((n-1)/7,new_cases7_pmX(n,1),[' ',country_leg],...
           'FontSize',font_location,...
           'color',color,...
           'Clipping','on');

end %Closes the loop
% -----------------------------------------------------------------------

% Aesthetic graphics settings
% -----------------------------------------------------------------------
figure (1);
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Acumulated deaths',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel (['Days since overtaking ',num2str(X_deaths),' deaths'],...
         'FontSize',font_labels);
ylabel ('Total deaths ','FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 100;
max_y  = 500000;
axis([0 day_axis y_init max_y]);

figure (2);
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Acumulated cases',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel (['Days since overtaking ',num2str(X_cases),' cases'],...
         'FontSize',font_labels);
ylabel ('Total cases ','FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 1000;
max_y  = 10000000;
axis([0 day_axis y_init max_y]);

figure (3);
set(gca,'FontSize',font_default);
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Epidemic progress (number of deaths)',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title)
xlabel ('Total deaths ','FontSize',font_labels);
ylabel ('New deaths per week','FontSize',font_labels);
legend ('location','northeastoutside');
max_x = 1000000;
max_y = 100000;
axis([0 max_x 0 max_y]);

figure (4);
set(gca,'FontSize',font_default);
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Epidemic progress (number of cases)',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title)
xlabel ('Total cases ','FontSize',font_labels);
ylabel ('New cases per week','FontSize',font_labels);
legend ('location','northeastoutside');
max_x = 40000000;
max_y = 1000000;
axis([0 max_x 0 max_y]);

figure (5);
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Weekly deaths',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel ({['Weeks since overtaking ',num2str(X_deaths),' deaths']},...
          'FontSize',font_labels);
ylabel ({'New deaths per week'},'FontSize',font_labels);
legend ('location', 'northeastoutside');
y_init = 1;
max_y  = 100000;
axis([0 day_axis/7 y_init max_y]);

figure (6);
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Weekly cases',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel ({['Weeks since overtaking ',num2str(X_cases),' cases']},...
          'FontSize',font_labels);
ylabel ({'New cases per week'},'FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 10;
max_y  = 1000000;
axis([0 day_axis/7 y_init max_y]);

figure(7)
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title({'Mortality of the epidemic',...
      ['Comparison between countries in ',datestr(end_time,23)]},...
       'FontSize',font_title);
xlabel({['Days since overtaking ',num2str(X_deaths_pm),' deaths'],...
         '(per million inhabitants)'},...
         'FontSize',font_labels);
ylabel ({'Total deaths ', '(per million inhabitants)'},...
         'FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 1;
max_y  = 3000;
axis([0 day_axis y_init max_y]);

figure (8)
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Prevalence of the epidemic',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel ({['Days since overtaking ',num2str(X_cases_pm),' cases'],...
          '(per million inhabitants)'},...
          'FontSize',font_labels);
ylabel ({'Total cases ','(per million inhabitants)'},...
         'FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 10;
max_y  = 10000;
axis([0 day_axis y_init max_y]);

figure(9)
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Weekly deaths per million',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel ({['Weeks since overtaking ',num2str(X_deaths_pm),' deaths'],...
          '(per million inhabitants)'},...
          'FontSize',font_labels);
ylabel ({'New deaths per week','(per million inhabitants)'},...
         'FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 0.01;
max_y  = 1000;
axis([0 day_axis/7 y_init max_y]);

figure (10)
set(gca,'FontSize',font_default)
set(gcf,'units','normalized','OuterPosition',[0 0 0.7 0.7])
title  ({'Weekly incidence',...
        ['Comparison between countries in ',datestr(end_time,23)]},...
         'FontSize',font_title);
xlabel ({['Weeks since overtaking ',num2str(X_cases_pm),' cases'],...
          '(per million inhabitants)'},...
          'FontSize',font_labels);
ylabel ({'New cases per week','(per million inhabitants)'},...
         'FontSize',font_labels);
legend ('location','northeastoutside');
y_init = 0.1;
max_y  = 10000;
axis([0 day_axis/7 y_init max_y]);

% Saving the charts
% -----------------------------------------------------------------------
print(figure( 1),['deaths-total-abs_'   ,datestr(end_time,29),'.png',],'-dpng','-r300');
print(figure( 2),['cases-total-abs_'    ,datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure( 3),['deaths-progress-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure( 4),['cases-progress-abs_' ,datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure( 5),['deaths-weekly-abs_'  ,datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure( 6),['cases-weekly-abs_'   ,datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure( 7),['mortality-pm_'       ,datestr(end_time,29),'.png',],'-dpng','-r300');
print(figure( 8),['prevalence-pm_'      ,datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure( 9),['deaths-weekly-pm_'   ,datestr(end_time,29),'.png',],'-dpng','-r300'); 
print(figure(10),['incidence-weekly-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 

close all