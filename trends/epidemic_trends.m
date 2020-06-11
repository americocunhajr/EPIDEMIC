%=======================================================================%
%                           EpidemicCode                                %
%                         epidemic_trends.m                             %
%                       www.EpidemicCode.org                            %
%                                                                       %
%                  - COVID-19 EM DIVERSOS PAÍSES  -                     %
%                                                                       %
% Este algoritmo gera gráficos sobre os números de casos e mortes por   %
% Covid-19 nos países de interesse.                                     %
%                                                                       %
% A série de gráficos contém:                                           %
% - número de casos em relação ao tempo desde X casos                   %
% - número de mortes em relação ao tempo desde X mortes                 %
% - número de novos casos por semana em relação ao total de casos       %
% - número de novas mortes por semana em relação ao total de mortes     %
%                                                                       %
% Você precisará do arquivo 'owid-covid-data.csv' encontrados em        %
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


% Comando para baixar automaticamente o arquivo de dados
% -----------------------------------------------------------------------
% fullURL  = ['https://covid.ourworldindata.org/data/owid-covid-data.csv'];
% filename = 'owid-covid-data.csv';
% urlwrite(fullURL,filename);


% Lendo o arquivo de dados 
%(se baixado manualmente deve estar no mesmo diretório)
% -----------------------------------------------------------------------
all_data = readtable('owid-covid-data.csv');
data = [all_data.total_cases,all_data.new_cases,all_data.total_deaths,all_data.new_deaths,all_data.total_cases_per_million,all_data.new_cases_per_million,all_data.total_deaths_per_million,all_data.new_deaths_per_million];
% -----------------------------------------------------------------------


% Executando o comando loop nos 14 países estudados
% -----------------------------------------------------------------------
for init = 1:1:14

    % Limpando variáveis reutilizadas dentro do loop
    clearvars -except plot_type init all_data data name paises tot_mortes tot_casos

    % Ordem por países que tem mais morte
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

    % Coletando os dados do país
    location = data(find(strcmp([all_data.location], country)),1:8);
    
    % Definindo a matriz com datas e o dia final
    dates    = all_data.date(find(strcmp([all_data.location],country)),:);
    end_time = max(datenum(dates))-1;
       
    % Separando os dados
    tot_cases  = location(:,1);
    new_cases  = location(:,2);
    tot_deaths = location(:,3);
    new_deaths = location(:,4);

    % Dados por milhão
    tot_cases_pm  = location(:,5);
    new_cases_pm  = location(:,6);
    tot_deaths_pm = location(:,7); 
    new_deaths_pm = location(:,8);   
    
    % Consolidando os novos casos e mortes por semana
    for i=7:1:max(max(size(dates)))  
            new_cases7(i,1) = new_cases(i,1)+new_cases(i-1,1) + new_cases(i-2,1) + new_cases(i-3,1) + new_cases(i-4,1)+ new_cases(i-5,1) + new_cases(i-6,1);
           new_deaths7(i,1) = new_deaths(i,1) + new_deaths(i-1,1) + new_deaths(i-2,1) + new_deaths(i-3,1) + new_deaths(i-4,1) + new_deaths(i-5,1) + new_deaths(i-6,1);
         new_cases7_pm(i,1) = new_cases_pm(i,1) + new_cases_pm(i-1,1) + new_cases_pm(i-2,1) + new_cases_pm(i-3,1) + new_cases_pm(i-4,1) + new_cases_pm(i-5,1) + new_cases_pm(i-6,1);
        new_deaths7_pm(i,1) = new_deaths_pm(i,1) + new_deaths_pm(i-1,1) + new_deaths_pm(i-2,1) + new_deaths_pm(i-3,1) + new_deaths_pm(i-4,1) + new_deaths_pm(i-5,1)+new_deaths_pm(i-6,1);
    end

    % Criando vetores desde dia zero a partir de X mortes ('_deaths')
    % ou a partir de X casos ('_cases').
    % Usuário define dia zero para casos ou mortes
    X_deaths_pm = 1;
    X_cases_pm  = 10;
    X_deaths    = 100;
    X_cases     = 1000;

    % Relativo ao total de mortes
    n=0;
    for i=1:1:max(max(size(dates))) 
        if (tot_deaths(i,1) >= X_deaths)
            n=n+1;
            tot_deaths_X(n,1)  = tot_deaths(i,1);
            new_deaths_X(n,1)  = new_deaths(i,1);
            new_deaths7_X(n,1) = new_deaths7(i,1);
        end
    end
    
    % Relativo ao total de casos
    n=0;
    for i=1:1:max(max(size(dates))) 
        if (tot_cases(i,1) >= X_cases)
            n=n+1;
            tot_cases_X(n,1)  = tot_cases(i,1);
            new_cases_X(n,1)  = new_cases(i,1);
            new_cases7_X(n,1) = new_cases7(i,1);
        end
    end
    
    % Relativo as mortes por milhão
    n=0;
    for i=1:1:max(max(size(dates))) 
        if (tot_cases_pm(i,1) >= X_cases_pm)
            n=n+1;
            tot_cases_pmX(n,1)  = tot_cases_pm(i,1);
            new_cases_pmX(n,1)  = new_cases_pm(i,1);
            new_cases7_pmX(n,1) = new_cases7_pm(i,1);
        end
    end
    
    % Relativo aos casos por milhão
    n=0;
    for i=1:1:max(max(size(dates))) 
        if (tot_deaths_pm(i,1) >= X_deaths_pm)
            n=n+1;
            tot_deaths_pmX(n,1)  = tot_deaths_pm(i,1);
            new_deaths_pmX(n,1)  = new_deaths_pm(i,1);
            new_deaths7_pmX(n,1) = new_deaths7_pm(i,1);
        end
    end

    % Fontes
    fonte_titulo   = 10.5;
    fonte_labels   = 10;
    fonte_padrao   = 9; 
    fonte_location = 8;

    % Tamanho dos gráficos
    day_axis = 120;
    
    %Tamanho dos gráficos    
    Pos = [0,250,900,450];
    set(0, 'DefaultFigurePosition', Pos);
    
    
    % Plotar total de mortes por tempo (dia zero definido por mortes)
    figure (1);
    n    = max(max(size(tot_deaths_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_deaths_X,'DisplayName',[country,'  ',num2str(max(tot_deaths)),' mortes'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,tot_deaths_X(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar total de casos por tempo (dia zero definido por casos)
    figure (2);
    n    = max(max(size(tot_cases_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_cases_X,'DisplayName',[country,'  ',num2str(max(tot_cases)),' casos'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,tot_cases_X(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novas mortes vs total de mortes
    figure (3);
    n    = max(max(size(tot_deaths)));
    fig  = loglog(tot_deaths,new_deaths7,'DisplayName',[country,'  ',num2str(max(tot_deaths)),' mortes'],'color',color,'LineWidth',1.25);
    hold on;
    text (tot_deaths(n,1),new_deaths7(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novos casos vs total de casos
    figure (4);
    n    = max(max(size(tot_cases)));
    fig  = loglog(tot_cases,new_cases7,'DisplayName',[country,'  ',num2str(max(tot_cases)),' casos'],'color',color,'LineWidth',1.25);
    hold on;
    text (tot_cases(n,1),new_cases7(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novas de mortes por tempo (dia zero definido por mortes)
    figure (5);
    n    = max(max(size(new_deaths_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_deaths7_X,'DisplayName',[country,'  ',num2str(max(tot_deaths)),' mortes'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,new_deaths7_X(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novos casos por tempo (dia zero definido por casos)
    figure (6);
    n    = max(max(size(new_cases_X)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_cases7_X,'DisplayName',[country,'  ',num2str(max(tot_cases)),' casos'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,new_cases7_X(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar total de mortes/milhao por tempo (dia zero definido por mortes/milhao)
    figure (7);
    n    = max(max(size(tot_deaths_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_deaths_pmX,'DisplayName',[country,'  ',num2str(max(tot_deaths)),' mortes'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,tot_deaths_pmX(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar total de casos/milhao por tempo (dia zero definido por casos/milhao)
    figure (8);
    n    = max(max(size(tot_cases_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,tot_cases_pmX,'DisplayName',[country,'  ',num2str(max(tot_cases)),' casos'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,tot_cases_pmX(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novas mortes vs total de mortes (por milhao de hab.)
    figure (9);
    n    = max(max(size(tot_deaths_pm)));
    fig  = loglog(tot_deaths_pm,new_deaths7_pm,'DisplayName',[country,'  ',num2str(max(tot_deaths)),' mortes'],'color',color,'LineWidth',1.25);
    hold on;
    text (tot_deaths_pm(n,1),new_deaths7_pm(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novos casos vs total de casos (por milhao de hab.)
    figure (10);
    n    = max(max(size(tot_cases_pm)));
    fig  = loglog(tot_cases_pm,new_cases7_pm,'DisplayName',[country,'  ',num2str(max(tot_cases)),' casos'],'color',color,'LineWidth',1.25);
    hold on;
    text (tot_cases_pm(n,1),new_cases7_pm(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novas de mortes/milhao por tempo (dia zero definido por mortes/milhao)
    figure (11);
    n    = max(max(size(new_deaths_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_deaths7_pmX,'DisplayName',[country,'  ',num2str(max(tot_deaths)),' mortes'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,new_deaths7_pmX(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

    % Plotar novos casos/milhao por tempo (dia zero definido por casos/milhao)
    figure (12);
    n    = max(max(size(new_cases_pmX)));
    days = 0:1:n-1;
    fig  = semilogy(days,new_cases7_pmX,'DisplayName',[country,'  ',num2str(max(tot_cases)),' casos'],'color',color,'LineWidth',1.25);
    hold on;
    text (n-1,new_cases7_pmX(n,1),[' ',country],'FontSize',fonte_location,'color',color,'Clipping','on');

end %Encerra o loop
% -----------------------------------------------------------------------


% Configurações estéticas dos gráficos
% -----------------------------------------------------------------------
    figure (1);
    set(gca,'FontSize',fonte_padrao)
    title({'Mortalidade da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel (['Dias desde que se ultrapassou ',num2str(X_deaths),' mortes'],'FontSize',fonte_labels);
    ylabel ('Total de mortes','FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (2);
    set(gca,'FontSize',fonte_padrao)
    title({'Contágio da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel (['Dias desde que se ultrapassou ',num2str(X_cases),' casos'],'FontSize',fonte_labels);
    ylabel ('Total de casos','FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (3);
    set(gca,'FontSize',fonte_padrao);
    title({'Informativo de progresso da epidemia (número de mortes)',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo)
    xlabel ('Total de mortes','FontSize',fonte_labels);
    ylabel('Novas mortes por semana','FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (4);
    set(gca,'FontSize',fonte_padrao);
    title({'Informativo de progresso da epidemia (número de casos)',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo)
    xlabel ('Total de casos','FontSize',fonte_labels);
    ylabel ('Novos casos por semana','FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (5);
    set(gca,'FontSize',fonte_padrao)
    title({'Mortalidade semanal da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel ({['Dias desde que se ultrapassou ',num2str(X_deaths),' mortes']},'FontSize',fonte_labels);
    ylabel ({'Novas mortes por semana'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (6);
    set(gca,'FontSize',fonte_padrao)
    title({'Contágio semanal da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel ({['Dias desde que se ultrapassou ',num2str(X_cases),' casos']},'FontSize',fonte_labels);
    ylabel ({'Novos casos por semana'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure(7)
    set(gca,'FontSize',fonte_padrao)
    title({'Mortalidade da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel({['Dias desde que se ultrapassou ',num2str(X_deaths_pm),' morte'],['(por milhão de habitantes)']},'FontSize',fonte_labels);
    ylabel ({'Total de mortes', '(por milhão de habitantes)'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (8)
    set(gca,'FontSize',fonte_padrao)
    title({'Contágio da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel({['Dias desde que se ultrapassou ',num2str(X_cases_pm),' casos'], '(por milhão de habitantes)'},'FontSize',fonte_labels);
    ylabel ({'Total de casos','(por milhão de habitantes)'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (9)
    set(gca,'FontSize',fonte_padrao);
    title({'Informativo de progresso da epidemia (número de mortes)',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo)
    xlabel ({'Total de mortes','(por milhão de habitantes)'},'FontSize',fonte_labels);
    ylabel({'Novas mortes por semana','(por milhão de habitantes)'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (10)
    set(gca,'FontSize',fonte_padrao);
    title({'Informativo de progresso da epidemia (número de casos)',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel ({'Total de casos','(por milhão de habitantes)'},'FontSize',fonte_labels);
    ylabel({'Novos casos por semana','(por milhão de habitantes)'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure(11)
    set(gca,'FontSize',fonte_padrao)
    title({'Mortalidade semanal da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel({['Dias desde que se ultrapassou ',num2str(X_deaths_pm),' morte'],'(por milhão de habitantes)'},'FontSize',fonte_labels);
    ylabel ({'Novas mortes por semana','(por milhão de habitantes)'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    figure (12)
    set(gca,'FontSize',fonte_padrao)
    title({'Contágio semanal da epidemia',['Comparação entre países em ',datestr(end_time,24)]},'FontSize',fonte_titulo);
    xlabel({['Dias desde que se ultrapassou ',num2str(X_cases_pm),' casos'],'(por milhão de habitantes)'},'FontSize',fonte_labels);
    ylabel ({'Novos casos por semana','(por milhão de habitantes)'},'FontSize',fonte_labels);
    legend ('location', 'northeastoutside');

    % Salvando os gráficos
    % -----------------------------------------------------------------------
    print(figure(1) ,['mortalidade-abs_',datestr(end_time,29),'.png',],'-dpng','-r300');
    print(figure(2) ,['contagio-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(3) ,['progresso-mortes-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(4) ,['progresso-casos-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(5) ,['mortalidade_semanal-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(6) ,['contagio_semanal-abs_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(7) ,['mortalidade-pm_',datestr(end_time,29),'.png',],'-dpng','-r300');
    print(figure(8) ,['contagio-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(9) ,['progresso-mortes-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(10),['progresso-casos-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(11),['mortalidade_semanal-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 
    print(figure(12),['contagio_semanal-pm_',datestr(end_time,29),'.png',],'-dpng','-r300'); 

close all





