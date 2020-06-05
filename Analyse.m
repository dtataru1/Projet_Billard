width = 854;
height=480;
Folder='F6';
Rband = 255;
Gband=89;
Bband = 114;
Rball = 53;
Gball=255;
Bball=0;
line='-';
X1 = [321  321  321  321  321  321  291  263  237  214  192  169  147  130  147  161  174  187  199  211  223  235  247  259  271  281  293  304  317  328  337  349  360  371  381  391  402  413  423  433  443  453  463  473  483  491  501  511  520  529  538  547  556  565  575  583  591  600  609  617  625  634  642  651  659  666  674  681  690  697  704  711  718  726  730  730  727  724  720  716  712  709  705  702  699  696  692  690  687  684  682  679  677  674  672  670  668  666  664  661  660  658  656  654
];
Y1 = [102  102  102  102  102  102  107  112  117  121  125  129  133  137  137  139  141  142  143  145  146  148  149  151  152  153  155  157  157  159  160  162  163  165  166  167  169  170  171  173  174  175  176  178  179  180  181  183  184  185  186  187  188  189  190  192  193  194  195  196  197  198  199  200  201  202  203  204  205  206  207  208  209  210  211  212  213  213  213  214  215  215  216  217  217  217  218  219  219  220  220  220  221  221  221  221  221  222  222  222  223  222  222  223
];
X2 = [442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  442  444  450  454  458  462  466  470  474  478  482  484  488  492  495  498  500  504  506  509  512  514  516  518  520  522  524  526  528  530  532  534  534  536  538  540  540  542  543  544  544  546  546  546  546  547  547  547  547  547
];
Y2 = [228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  228  227  227  227  227  227  227  227  227  227  227  227  227  227  226  226  226  226  226  226  226  226  226  226  226  226  226  226  226  226  226  227  226  227  227  227  227  227  227  227  227  227  227  227  227  227  227
];
X3 = [500  500  462  412  374  336  324  312  297  280  262  245  229  214  197  182  166  148  133  134  144  153  161  171  180  188  197  206  215  224  233  243  251  260  269  277  286  295  303  311  319  327  335  343  351  358  366  373  381  389  396  403  410  417  424  428  429  429  430  431  431  432  432  433  434  434  435  435  436  436  437  437  437  438  438  438  439  439  439  439  440  440  441  441  441  442  442  443  443  443  443  444  444  444  445  445  445  445  445  445  445  446  446  446
];
Y3 = [173  173  156  134  117  100  112  128  143  157  171  185  198  210  224  236  249  263  275  288  300  312  324  336  347  359  371  382  389  382  375  368  362  355  349  342  336  330  324  317  311  305  299  294  288  282  276  271  265  260  254  249  243  238  233  228  223  219  215  211  207  203  199  195  191  188  184  181  177  174  171  168  165  162  159  156  154  151  149  147  144  142  140  138  136  134  133  131  129  128  126  125  124  123  122  121  120  119  118  118  117  117  117  116
];
%% File Header
% MATLAB Script Analyse.m file
%
% Group : Axel Rossettini   SCIPER: 303157
%         Daniel Tataru     SCIPER: 301005
%         Ellie Tupin       SCIPER: 296441
%
% This script determines the score of each sequence (an Analyse.m file is
% generated at each launch of the LabView program containing this script
% preceeded by the coordinates of the balls of the sequence)
%
% Revision: 
%           04.2020 Initial release
%           05.2020 Final version 
%
% Coded on MATLAB R2020A/R2019b on macOS
%% Changement des coordonnées pour matlab

Y1 = (height - Y1);
Y2 = (height - Y2);
Y3 = (height - Y3);

%% Normalisation des valeurs RGB

Ballcol = [Rball Gball Bball]./255;
Bandcol = [Rband Gband Bband]./255;

%% Détection des bords

Xmin = min([X1,X2,X3]);
Xmax = max([X1,X2,X3]);
Ymin = min([Y1,Y2,Y3]);
Ymax = max([Y1,Y2,Y3]);

Xframe = [Xmin Xmax Xmax Xmin Xmin];
Yframe = [Ymin Ymin Ymax Ymax Ymin];

%% Détection des valeurs absurdes

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

%Gestion du cas ou la première image est considérée comme absurde
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

%Remplacement par la valeur précédant la valeur absurde
X1(OX1id)=X1(OX1id-1);
Y1(OY1id)=Y1(OY1id-1);
X2(OX2id)=X2(OX2id-1);
Y2(OY2id)=Y2(OY2id-1);
X3(OX3id)=X3(OX3id-1);
Y3(OY3id)=Y3(OY3id-1);


%% Détection de la premiere balle qui bouge

%d désigne la distance minimale ou l'on considère que la balle bouge par
%rapport à sa position initiale
d=2;

distB1 = sqrt((X1-X1(1)).^2+(Y1-Y1(1)).^2);
distB2 = sqrt((X2-X2(1)).^2+(Y2-Y2(1)).^2);
distB3 = sqrt((X3-X3(1)).^2+(Y3-Y3(1)).^2);
    
mb1=find(distB1>d, 1);
mb2=find(distB2>d, 1);
mb3=find(distB3>d, 1);

%% Calcul du nombre de boules touchées

touch = 2;

if isempty(mb1) 
   mb1 = size(X1,2);
   touch = touch - 1;
end
if isempty(mb2) 
   mb2 = size(X2,2); 
      touch = touch - 1;

end
if isempty(mb3) 
   mb3 = size(X3,2);
      touch = touch - 1;
end

%% Détermination de l'ordre de mouvement des boules

A=[mb1,mb2,mb3];
[tfirst,ifirst] = min(A);
[tthird, ithird] = max(A);
A(ifirst) = [];
tsecond = min(A);

switch ifirst
    case 1
    XFIRST = X1;
    YFIRST = Y1;
    player = 'Score Sheet for "Red" ';
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
    player = 'Score Sheet for "Yellow" ';
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
    player = 'Score Sheet for "White" ';
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

%% Détection des chocs entre la premère boule et les bandes
dboule = 9;

rbndXmin = find(abs(XFIRST-Xmin)<= dboule);
rbndXmin = rbndXmin(rbndXmin>=tsecond & rbndXmin<=tthird & abs(diff([0,rbndXmin]))>1);
    
rbndXmax = find(abs(XFIRST-Xmax)<= dboule);
rbndXmax = rbndXmax(rbndXmax>=tsecond & rbndXmax<=tthird & abs(diff([0,rbndXmax]))>1);
    
rbndYmin = find(abs(YFIRST-Ymin)<= dboule);
rbndYmin = rbndYmin(rbndYmin>=tsecond & rbndYmin<=tthird & abs(diff([0,rbndYmin]))>1);
    
rbndYmax = find(abs(YFIRST-Ymax)<= dboule);
rbndYmax = rbndYmax(rbndYmax>=tsecond & rbndYmax<=tthird & abs(diff([0,rbndYmax]))>1);
 

rebondsentre = size(rbndXmin,2) + size(rbndXmax,2) + size(rbndYmin,2) + size(rbndYmax,2);
               
%% Calcul des distances parcourues par chaque boule    
    
DistR = sum(sqrt(diff(X1).^2 + diff(Y1).^2));
DistY = sum(sqrt(diff(X2).^2 + diff(Y2).^2));
DistW = sum(sqrt(diff(X3).^2 + diff(Y3).^2));
    
%% Verdict de la partie
if touch == 2 && rebondsentre >= 3
    verdict = 'Status : Win';
else
    verdict = 'Status : Loss';
end

%% Affichage de la figure

%Affichage de la date et l'heure
c = clock;
h = num2str(c(4));
min = num2str(c(5));
s = num2str(floor(c(6)));
time = strcat(h,':',min,':',s);

figure(1);
hold on
    title(['Score Sheet',' ',Folder ,' ', date, ' ', time]);
    ylim([0,Ymax+20]);
    plot(Xframe, Yframe,'-b','DisplayName','Bords du billard','LineWidth',2);
    plot(X1,Y1,line,'DisplayName','Boule rouge', 'Color', [1 0 0]);
    plot(X2,Y2,line,'DisplayName','Boule jaune', 'Color', [0.8 0.8 0]);
    plot(X3,Y3,line,'DisplayName', 'Boule blanche', 'Color', [0 0 0]);
    plot(XFIRST(rbndXmin),YFIRST(rbndXmin),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    plot(XFIRST(rbndXmax),YFIRST(rbndXmax),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    plot(XFIRST(rbndYmin),YFIRST(rbndYmin),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    plot(XFIRST(rbndYmax),YFIRST(rbndYmax),'o','MarkerSize',6, 'MarkerFaceColor', Bandcol, 'MarkerEdgeColor', Bandcol);
    
    if touch >= 1
    plot(XFIRST(tsecond),YFIRST(tsecond),'o','MarkerSize',8, 'MarkerFaceColor', Ballcol, 'MarkerEdgeColor', Ballcol);
    end
    if touch == 2
    plot(XFIRST(tthird),YFIRST(tthird),'o','MarkerSize',8, 'MarkerFaceColor', Ballcol, 'MarkerEdgeColor', Ballcol);
    end
    
    text(Xmin, 70, player);
    text(Xmin+50, 50, verdict);
    text(Xmax-250, 70, ['Number of balls touched : ',num2str(touch)]);
    text(Xmax-300, 50, ['Number of bands touched between balls : ',num2str(rebondsentre)]);
    text(Xmin, 20, ['Dist(r) : ',num2str(round(DistR)),'px']);
    text(Xmin+200, 20, ['Dist(y) : ',num2str(round(DistY)),'px']);
    text(Xmin+400, 20, ['Dist(w) : ',num2str(round(DistW)),'px']);
    hold off

%Saving as a pdf and also a png in order to display it directly in LabVieW
%(the png will be overwriten at each sequence, but the pdf will have the
% sequence name next to it)
print(strcat('ScoreSheet','_',Folder),'-dpdf');
print('ScoreSheet','-dpng');