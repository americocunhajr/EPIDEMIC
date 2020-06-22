%=======================================================================%
%                                                                       %
%            EPIDEMIC - Epidemiology Educational Code                   %
%                       www.EpidemicCode.org                            %
% --------------------------------------------------------------------- %
%                         epidemic_trends.m                             %
% --------------------------------------------------------------------- %
%                                                                       %
%                  -  EPIDEMIC TRENDS GRAPHICS  -                       %
%                                                                       %
% This algorithm generates graphs on the numbers of cases and deaths    %
% by epidemic in the countries of interest.                             % 
%                                                                       %
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
%                                                                       %
%                                                                       %
%                             Malú Grave                                %
%                         malugravemg@gmail.com                         %
%                        malugrave@nacad.ufjr.br                        %
%                                                                       %
%         [ ] Working                                                   %
% Status: [ ] Not working                                               %
%         [x] Experimental                                              %
%                                                                       %
% Last Update [05/06/2020]                                              %
%=======================================================================%


clc;
clear all;
close all;


% Command to automatically download the data file
% -----------------------------------------------------------------------
% fullURL  = ['https://covid.ourworldindata.org/data/owid-covid-data.csv'];
% filename = 'owid-covid-data.csv';
% urlwrite(fullURL,filename);


% Reading the data file
%(if downloaded manually it must be in the same directory)
% -----------------------------------------------------------------------
all_data = readtable('owid-covid-data.csv');
data     = [all_data.total_cases,...
            all_data.new_cases,...
            all_data.total_deaths,...
            all_data.new_deaths,...
            all_data.total_cases_per_million,...
            all_data.new_cases_per_million,...
            all_data.total_deaths_per_million,...
            all_data.new_deaths_per_million];
% -----------------------------------------------------------------------


% Running the loop command in the 14 countries studied
% -----------------------------------------------------------------------
for init = 1:1:14

    % Cleaning up reused variables inside the loop
    clearvars -except plot_type init all_data data name paises tot_deaths tot_cases

    % Order by countries that have more death
    if (init == 3);  country = 'Brazil';         color = [  0,  0,  0]/255; end
    if (init == 14); country = 'South Korea';    color = [ 69,169,  0]/255; end
    if (init == 12); country = 'Turkey';         color = [ 96,209,224]/255; end  
    if (init == 11); country = 'Peru';           color = [181,147, 87]/255; end
    if (init == 9);  country = 'Iran';           color = [255,130,113]/255; end
    if (init == 8);  country = 'Germany';        color = [209,227,105]/255; end
    if (init == 13); country = 'Chile';          color = [248,187,208]/255; end
    if (init == 1);  country = 'United States';  color = [  0,104, 44]/255; end
    if (init == 5);  country = 'France';         color = [  0, 45,135]/255; end
    if (init == 2);  country = 'United Kingdom'; color = [135, 85, 30]/255; end
    if (init == 4);  country = 'Italy';          color = [203, 63, 23]/255; end
    if (init == 6);  country = 'Spain';          color = [191,171, 72]/255; end
    if (init == 7);  country = 'Belgium';        color = [236, 64,122]/255; end
    if (init == 10); country = 'Russia';         color = [0.4,0.4,0.4];     end

    % Collecting country data
    location = data(find(strcmp([all_data.location], country)),1:8);
    
    % Defining the matrix with dates and the final day
    dates    = all_data.date(find(strcmp([all_data.location],country)),:);
    end_time = max(datenum(dates))-1;
       
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
    for i=7:1:max(max(size(dates)))  
            new_cases7(i,1) = new_cases(i,1)   + ...
                              new_cases(i-1,1) + ... 
                              new_cases(i-2,1) + ...
                              new_cases(i-3,1) + ...
                              new_cases(i-4,1) + ...
                              new_cases(i-5,1) + ...
                              new_cases(i-6,1);
                          
           new_deaths7(i,1) = new_deaths(i,1)   + ...
                              new_deaths(i-1,1) + ...
                              new_deaths(i-2,1) + ...
                              new_deaths(i-3,1) + ...
                              new_deaths(i-4,1) + ...
                              new_deaths(i-5,1) + ...
                              new_deaths(i-6,1);
                          
         new_cases7_pm(i,1) = new_cases_pm(i,1)   + ...
                              new_cases_pm(i-1,1) + ...
                              new_cases_pm(i-2,1) + ...
                              new_cases_pm(i-3,1) + ...
                              new_cases_pm(i-4,1) + ...
                              new_cases_pm(i-5,1) + ...
                              new_cases_pm(i-6,1);
                          
        new_deaths7_pm(i,1) = new_deaths_pm(i,1)   + ...
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
        if (tot_deaths(i,1) >= X_deaths)
            n = n+1;
            tot_deaths_X(n,1)  = tot_deaths(i,1);
            new_deaths_X(n,1)  = new_deaths(i,1);
            new_deaths7_X(n,1) = new_deaths7(i,1);
        end
    end
    
    % Relative to total cases
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_cases(i,1) >= X_cases)
            n = n+1;
            tot_cases_X(n,1)  = tot_cases(i,1);
            new_cases_X(n,1)  = new_cases(i,1);
            new_cases7_X(n,1) = new_cases7(i,1);
        end
    end
    
    % Related deaths per million
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_cases_pm(i,1) >= X_cases_pm)
            n = n+1;
            tot_cases_pmX(n,1)  = tot_cases_pm(i,1);
            new_cases_pmX(n,1)  = new_cases_pm(i,1);
            new_cases7_pmX(n,1) = new_cases7_pm(i,1);
        end
    end
    
    % Related cases per million
    n = 0;
    for i = 1:1:max(max(size(dates))) 
        if (tot_deaths_pm(i,1) >= X_deaths_pm)
            n = n+1;
            tot_deaths_pmX(n,1)  = tot_deaths_pm(i,1);
            new_deaths_pmX(n,1)  = new_deaths_pm(i,1);
            new_deaths7_pmX(n,1) = new_deaths7_pm(i,1);
        end
    end

    % Fonts
    font_title    = 10.5;
    font_labels   = 10;
    font_default  = 9; 
    font_location = 8;

    % X-axis size
    day_axis = 120;
    
    % Graphics size    
    Pos = [0,250,900,450];
    set(0, 'DefaultFigurePosition', Pos);
    
    
    % Plot total deaths by time (zero day defined by deaths)
    figure (1);
    n    = max(max(size(tot_deaths_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_deaths_X,...
          'DisplayName',[country,'  ',num2str(max(tot_deaths)),' deaths'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,tot_deaths_X(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,'Clipping','on');

    % Plot total cases by time (day zero defined by cases)
    figure (2);
    n    = max(max(size(tot_cases_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_cases_X,...
          'DisplayName',[country,'  ',num2str(max(tot_cases)),' cases'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,tot_cases_X(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new deaths vs total deaths
    figure (3);
    n    = max(max(size(tot_deaths)));
    fig  = loglog(tot_deaths,new_deaths7,...
          'DisplayName',[country,'  ',num2str(max(tot_deaths)),' deaths'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (tot_deaths(n,1),new_deaths7(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new cases vs total cases
    figure (4);
    n    = max(max(size(tot_cases)));
    fig  = loglog(tot_cases,new_cases7,...
           'DisplayName',[country,'  ',num2str(max(tot_cases)),' cases'],...
           'color',color,...
           'LineWidth',1.25);
    hold on;
    text (tot_cases(n,1),new_cases7(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new deaths by time (zero day defined by deaths)
    figure (5);
    n    = max(max(size(new_deaths_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_deaths7_X,...
          'DisplayName',[country,'  ',num2str(max(tot_deaths)),' deaths'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,new_deaths7_X(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new cases by time (day zero defined by cases)
    figure (6);
    n    = max(max(size(new_cases_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_cases7_X,...
          'DisplayName',[country,'  ',num2str(max(tot_cases)),' cases'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,new_cases7_X(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot total deaths / million by time (zero day defined by deaths / million)
    figure (7);
    n    = max(max(size(tot_deaths_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_deaths_pmX,...
          'DisplayName',[country,'  ',num2str(max(tot_deaths)),' deaths'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,tot_deaths_pmX(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot total cases / million by time (day zero defined by cases / million)
    figure (8);
    n    = max(max(size(tot_cases_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_cases_pmX,...
          'DisplayName',[country,'  ',num2str(max(tot_cases)),' cases'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,tot_cases_pmX(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new deaths vs total deaths (per million inhab.)
    figure (9);
    n    = max(max(size(tot_deaths_pm)));
    fig  = loglog(tot_deaths_pm,new_deaths7_pm,...
          'DisplayName',[country,'  ',num2str(max(tot_deaths)),' deaths'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (tot_deaths_pm(n,1),new_deaths7_pm(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new cases vs total cases (per million inhab.)
    figure (10);
    n    = max(max(size(tot_cases_pm)));
    fig  = loglog(tot_cases_pm,new_cases7_pm,...
          'DisplayName',[country,'  ',num2str(max(tot_cases)),' cases'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (tot_cases_pm(n,1),new_cases7_pm(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new deaths / million by time (zero day defined by deaths / million)
    figure (11);
    n    = max(max(size(new_deaths_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_deaths7_pmX,...
          'DisplayName',[country,'  ',num2str(max(tot_deaths)),' deaths'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,new_deaths7_pmX(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

    % Plot new cases / million by time (day zero defined by cases / million)
    figure (12);
    n    = max(max(size(new_cases_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_cases7_pmX,...
          'DisplayName',[country,'  ',num2str(max(tot_cases)),' cases'],...
          'color',color,...
          'LineWidth',1.25);
    hold on;
    text (n-1,new_cases7_pmX(n,1),[' ',country],...
         'FontSize',font_location,...
         'color',color,...
         'Clipping','on');

end %Closes the loop
% -----------------------------------------------------------------------


% Aesthetic graphics settings
% -----------------------------------------------------------------------
    figure (1);
    set(gca,'FontSize',font_default)
    title({'Mortality of the epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel (['Days since overtaking ',num2str(X_deaths),' deaths'],'FontSize',font_labels);
    ylabel ('Total deaths ','FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (2);
    set(gca,'FontSize',font_default)
    title({'Spread of epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel (['Days since overtaking ',num2str(X_cases),' cases'],'FontSize',font_labels);
    ylabel ('Total cases ','FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (3);
    set(gca,'FontSize',font_default);
    title({'Epidemic progress (number of deaths)',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title)
    xlabel ('Total deaths ','FontSize',font_labels);
    ylabel('New deaths per week','FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (4);
    set(gca,'FontSize',font_default);
    title({'Epidemic progress (number of cases)',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title)
    xlabel ('Total cases ','FontSize',font_labels);
    ylabel ('New cases per week','FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (5);
    set(gca,'FontSize',font_default)
    title({'Weekly mortality of the epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel ({['Days since overtaking ',num2str(X_deaths),' deaths']},'FontSize',font_labels);
    ylabel ({'New deaths per week'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (6);
    set(gca,'FontSize',font_default)
    title({'Weekly spread of epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel ({['Days since overtaking ',num2str(X_cases),' cases']},'FontSize',font_labels);
    ylabel ({'New cases per week'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure(7)
    set(gca,'FontSize',font_default)
    title({'Mortality of the epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel({['Days since overtaking ',num2str(X_deaths_pm),' deaths'],'(per million inhabitants)'},'FontSize',font_labels);
    ylabel ({'Total deaths ', '(per million inhabitants)'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (8)
    set(gca,'FontSize',font_default)
    title({'Spread of epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel({['Days since overtaking ',num2str(X_cases_pm),' cases'], '(per million inhabitants)'},'FontSize',font_labels);
    ylabel ({'Total cases ','(per million inhabitants)'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (9)
    set(gca,'FontSize',font_default);
    title({'Epidemic progress (number of deaths)',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title)
    xlabel ({'Total deaths ','(per million inhabitants)'},'FontSize',font_labels);
    ylabel({'New deaths per week','(per million inhabitants)'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (10)
    set(gca,'FontSize',font_default);
    title({'Epidemic progress (number of cases)',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel ({'Total cases ','(per million inhabitants)'},'FontSize',font_labels);
    ylabel({'New cases per week','(per million inhabitants)'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure(11)
    set(gca,'FontSize',font_default)
    title({'Weekly mortality of the epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel({['Days since overtaking ',num2str(X_deaths_pm),' deaths'],'(per million inhabitants)'},'FontSize',font_labels);
    ylabel ({'New deaths per week','(per million inhabitants)'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    figure (12)
    set(gca,'FontSize',font_default)
    title({'Weekly spread of epidemic',['Comparison between countries in ',datestr(end_time,24)]},'FontSize',font_title);
    xlabel({['Days since overtaking ',num2str(X_cases_pm),' cases'],'(per million inhabitants)'},'FontSize',font_labels);
    ylabel ({'New cases per week','(per million inhabitants)'},'FontSize',font_labels);
    legend ('location', 'northeastoutside');

    % Saving the charts
    % -----------------------------------------------------------------------
    print(figure(1) ,['mortality-abs_',datestr(end_time,29),'.png',],'-dpng','-r300');
    print(figure(2) ,['spread-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(3) ,['progress-deaths-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(4) ,['progress-cases-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(5) ,['mortality_weekly-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(6) ,['spread_weekly-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(7) ,['mortality-pm_',datestr(end_time,29),'.png',],'-dpng','-r300');
    print(figure(8) ,['spread-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(9) ,['progress-deaths-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(10),['progress-cases-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(11),['mortality_weekly-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(12),['spread_weekly-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 

close all
