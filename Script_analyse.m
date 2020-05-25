%% Changement des coordonnées pour matlab

Y1 = (height - Y1);
Y2 = (height - Y2);
Y3 = (height - Y3);

Ballcol = [Rball Gball Bball]./255;
Bandcol = [Rband Gband Bband]./255;

%% Detection des bords
Xmin = min([X1,X2,X3]);
Xmax = max([X1,X2,X3]);
Ymin = min([Y1,Y2,Y3]);
Ymax = max([Y1,Y2,Y3]);

Xframe = [Xmin Xmax Xmax Xmin Xmin];
Yframe = [Ymin Ymin Ymax Ymax Ymin];

OX1=isoutlier(X1,'movmedian',5);
OY1=isoutlier(Y1,'movmedian',5);
OX2=isoutlier(X2,'movmedian',5);
OY2=isoutlier(Y2,'movmedian',5);
OX3=isoutlier(X3,'movmedian',5);
OY3=isoutlier(Y3,'movmedian',5);

OX1id = find(OX1);
OY1id = find(OY1);
OX2id = find(OX2);
OY2id = find(OY2);
OX3id = find(OX3);
OY3id = find(OY3);

if isempty(OX1id) == 0  
    if OX1id(1) == 1
    OX1id(1) = [];
    end
end
if isempty(OY1id) == 0  
    if OY1id(1) == 1
    OY1id(1) = [];
    end
end
if isempty(OX2id) == 0  
    if OX2id(1) == 1
    OX2id(1) = [];
    end
end
if isempty(OY2id) == 0  
    if OY2id(1) == 1
    OY2id(1) = [];
    end
end
if isempty(OX3id) == 0  
    if OX3id(1) == 1
    OX3id(1) = [];
    end
end
         
if isempty(OY3id) == 0  
    if OY3id(1) == 1
    OY3id(1) = [];
    end
end

X1(OX1id)=X1(OX1id-1);
Y1(OY1id)=Y1(OY1id-1);
X2(OX2id)=X2(OX2id-1);
Y2(OY2id)=Y2(OY2id-1);
X3(OX3id)=X3(OX3id-1);
Y3(OY3id)=Y3(OY3id-1);


%% Détection de la premiere balle qui bouge
    
d=2;

distB1 = sqrt((X1-X1(1)).^2+(Y1-Y1(1)).^2);
distB2 = sqrt((X2-X2(1)).^2+(Y2-Y2(1)).^2);
distB3 = sqrt((X3-X3(1)).^2+(Y3-Y3(1)).^2);
    
mb1=find(distB1>d, 1);
mb2=find(distB2>d, 1);
mb3=find(distB3>d, 1);

touch = 2;

if isempty(mb1) 
   mb1 = size(X1,2)-2;
   touch = touch - 1;
end
if isempty(mb2) 
   mb2 = size(X2,2)-2; 
      touch = touch - 1;

end
if isempty(mb3) 
   mb3 = size(X3,2)-2;
      touch = touch - 1;
end

%plus petit indice de début de mouvement tfirst et numero de la boule ifirst

A=[mb1,mb2,mb3];
[tfirst,ifirst] = min(A);
[tthird, ithird] = max(A);
A(ifirst) = [];
tsecond = min(A);

%deteciton des rebonds contre les bandes de la balle I
dboule = 9;

switch ifirst
    case 1
    XFIRST = X1;
    YFIRST = Y1;
    player = 'ScoreSheet for "Red" ';
    switch ithird
        case 2
            XSECOND = X3;
            YSECOND = Y3;
            XTHIRD = X2;
            YTHIRD = Y2;
            
        case 3
            XSECOND = X2;
            YSECOND = Y2;
            XTHIRD = X3;
            YTHIRD = Y3;
            
    end
    
    case 2
    XFIRST = X2;
    YFIRST = Y2;
    player = 'ScoreSheet for "Yellow" ';
            switch ithird
        case 1
            XSECOND = X3;
            YSECOND = Y3;
            XTHIRD = X1;
            YTHIRD = Y1;
        case 3
            XSECOND = X1;
            YSECOND = Y1;
            XTHIRD = X3;
            YTHIRD = Y3;
            end
    case 3
    XFIRST = X3;
    YFIRST = Y3;
    player = 'ScoreSheet for "White" ';
     switch ithird
        case 1
            XSECOND = X2;
            YSECOND = Y2;
            XTHIRD = X1;
            YTHIRD = Y1;
        case 2
            XSECOND = X1;
            YSECOND = Y1;
            XTHIRD = X2;
            YTHIRD = Y2;    
    end
end

    rbndXmin = find(abs(XFIRST-Xmin)<= dboule);
    rbndXmin = rbndXmin(rbndXmin >=tfirst & abs(diff([0,rbndXmin]))>1);
    
    rbndXmax = find(abs(XFIRST-Xmax)<= dboule);
    rbndXmax = rbndXmax(rbndXmax >=tfirst & abs(diff([0,rbndXmax]))>1);
    
    rbndYmin = find(abs(YFIRST-Ymin)<= dboule);
    rbndYmin = rbndYmin(rbndYmin >=tfirst & abs(diff([0,rbndYmin]))>1);
    
    rbndYmax = find(abs(YFIRST-Ymax)<= dboule);
    rbndYmax = rbndYmax(rbndYmax >=tfirst & abs(diff([0,rbndYmax]))>1);
    
    nbrebonds = size(rbndXmin,2) + size(rbndXmax,2) + size(rbndYmin,2) + size(rbndYmax,2);
    
    rebondsentre = size(rbndXmin(rbndXmin>=tsecond & rbndXmin<=tthird),2)...
        +size(rbndXmax(rbndXmax>=tsecond & rbndXmax<=tthird),2)...
        +size(rbndYmin(rbndYmin>=tsecond & rbndYmin<=tthird),2)...
        +size(rbndYmax(rbndYmax>=tsecond & rbndYmax<=tthird),2);
         
    
    DistR = sum(sqrt(diff(X1).^2 + diff(Y1).^2));
    DistY = sum(sqrt(diff(X2).^2 + diff(Y2).^2));
    DistW = sum(sqrt(diff(X3).^2 + diff(Y3).^2));
    
%% Detection des chocs entre les boules   

% chocs12 = find(abs(YFIRST(tsecond-2:tsecond+2)-YSECOND(tsecond-2:tsecond+2))<=35 & abs(XFIRST(tsecond-2:tsecond+2)-XSECOND(tsecond-2:tsecond+2))<=35);
%   
% chocs13 = find(abs(YFIRST(tthird)-YTHIRD(tthird))<=35 & abs(XFIRST(tthird)-XTHIRD(tthird))<=35);
%     
% if isempty(chocs12) == 1 || touch<1
%     fprintf('pas de choc sur\n');
% else
%     fprintf('choc sur photo %d\n',tsecond);
% end
% 
% if isempty(chocs13) == 1 || touch < 2
% 
%     fprintf('pas de choc sur\n');
% else
%     fprintf('choc sur photo %d\n',tthird);
% end


if touch == 2 && rebondsentre >= 3
    score = 'Status : Win';
else
    score = 'Status : Loss';
end

%% Affichage de la figure
c = clock;
h = num2str(c(4));
min = num2str(c(5));
s = num2str(floor(c(6)));
time = strcat(h,':',min,':',s);

figure(1);
hold on
    title(['Score Sheet',' ',Folder ,' ', date, ' ', time]);
    ylim([0,Ymax+20]);
    plot(Xframe, Yframe,'-b','DisplayName','Bords du billard','LineWidth',4);
    plot(X1,Y1,line,'DisplayName','Boule rouge', 'Color', [1 0 0]);
    plot(X2,Y2,line,'DisplayName','Boule jaune', 'Color', [0.98 0.98 0]);
    plot(X3,Y3,line,'DisplayName', 'Boule blanche', 'Color', [0 0 0]);
    plot(XFIRST(rbndXmin),YFIRST(rbndXmin),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    plot(XFIRST(rbndXmax),YFIRST(rbndXmax),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    plot(XFIRST(rbndYmin),YFIRST(rbndYmin),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    plot(XFIRST(rbndYmax),YFIRST(rbndYmax),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    
    if touch == 1
    plot(XFIRST(tsecond),YFIRST(tsecond),'o','MarkerSize',8, 'MarkerFaceColor', Ballcol, 'MarkerEdgeColor', Ballcol);
    end
    if touch == 2
    plot(XFIRST(tthird),YFIRST(tthird),'o','MarkerSize',8, 'MarkerFaceColor', Ballcol, 'MarkerEdgeColor', Ballcol);
    end
    
    text(Xmin, 70, player);
    text(Xmin+50, 50, score);
    text(Xmax-250, 80, ['Number of balls touched : ',num2str(touch)]);
    text(Xmax-250, 65, ['Number of bands touched : ',num2str(nbrebonds)]);
    text(Xmax-300, 50, ['Number of bands touched between balls : ',num2str(rebondsentre)]);
    text(Xmin, 20, ['Dist(r) : ',num2str(DistR)]);
    text(Xmin+200, 20, ['Dist(y) : ',num2str(DistY)]);
    text(Xmin+400, 20, ['Dist(w) : ',num2str(DistW)]);
    hold off
             
print('ScoreSheet','-dpdf');
print('ScoreSheet','-dpng');