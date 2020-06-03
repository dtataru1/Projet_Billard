width = 854;
height=480;
Folder='F2n';
Rband = 255;
Gband=89;
Bband = 114;
Rball = 53;
Gball=255;
Bball=0;
line='-';
X1 = [681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  681  680  680  680  681  680  680  680  680  680  680  678  676  675  673  671  670  668  667  665  665  663  663  662  661  660  659  659  658  657  657  656  656
];
Y1 = [180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  180  179  177  175  173  171  169  168  166  165  163  162  161  159  159  158  157  156  156  155  155  154  154  154  154  153  153  153  153  153  153  153  153  153  153  153  153  153  152
];
X2 = [160  188  231  287  341  390  436  481  528  576  625  677  724  705  664  628  596  568  542  517  492  468  444  420  395  372  348  324  302  278  255  232  209  186  163  140  138  155  169  181  194  206  218  230  243  255  267  280  290  302  314  326  338  349  360  372  382  394  404  414  426  436  446  456  466  476  486  496  506  516  526  536  544  554  564  572  582  592  600  610  618  627  636  644  653  662  670  678  686  696  704  712  720  728  731  726  722  718  713  709  705  700  696  693  691  690  689  688  686  685  684  683  682  680  680  679  678  677  676  675  674  674  672  672  672  670
];
Y2 = [187  256  324  334  346  357  369  382  389  381  375  369  364  347  326  306  288  270  253  235  218  201  183  167  150  133  117  100  108  118  127  137  146  155  164  173  184  198  210  223  235  248  260  272  284  296  308  320  332  344  356  367  379  390  383  376  370  364  357  352  345  339  333  326  321  315  309  303  297  291  286  280  274  269  263  258  253  248  242  236  231  226  221  216  211  206  201  196  192  190  187  185  182  180  177  174  171  169  166  163  160  158  155  153  150  147  145  142  139  137  134  132  130  128  126  124  122  120  118  117  115  114  112  111  110  109
];
X3 = [213  213  210  195  183  172  162  152  150  148  146  144  142  140  137  135  133  134  134  134  134  134  135  135  135  135  135  135  135  135  135  135  135  135  136  136  136  136  136  135  135  135  135  135  135  135  135  135  134  134  134  134  134  134  134  133  133  133  133  133  133  133  132  132  132  132  132  132  131  131  131  131  131  131  131  131  131  131  132  132  132  132  132  132  132  132  132  132  132  132  132  132  132  132  131  642  131  659  131  131  130  130  130  130  130  130  130  131  131  130  130  130  130  131  131  131  131  131  131  131  131  131  131  131  131  131
];
Y3 = [334  334  353  342  273  209  151  100  137  180  217  252  284  316  348  379  374  350  330  313  295  278  261  243  226  209  193  176  160  143  126  110  100  112  121  130  139  148  157  166  175  183  192  200  208  217  225  233  241  249  257  264  272  279  287  294  301  308  316  323  329  336  343  349  356  362  368  374  380  386  390  387  383  380  377  374  371  369  366  363  360  358  356  353  351  349  347  345  343  341  339  337  336  334  333  93  330  93  328  327  326  325  324  324  323  323  322  322  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321
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
    plot(Xframe, Yframe,'-b','DisplayName','Bords du billard','LineWidth',4);
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
    text(Xmax-250, 80, ['Number of balls touched : ',num2str(touch)]);
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