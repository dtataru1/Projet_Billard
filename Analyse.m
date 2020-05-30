width = 854;
height=480;
Folder='F3';
Rband = 255;
Gband=89;
Bband = 114;
Rball = 53;
Gball=255;
Bball=0;
line='-';
X1 = [286  286  286  286  287  308  330  353  371  386  397  408  419  431  442  453  465  478  489  499  510  523  534  547  558  570  581  593  606  618  631  641  649  657  665  673  681  689  697  705  712  720  728  733  729  725  721  717  714  710  707  704  700  697  694  691  688  685  682  679  677  673  671  668  666  663  661  659  656  654  652  650  648  646  644  642  640  639  637  635  634  632  630  630  628  627  626  625  624  623  622  621  620  620  619  619  618  618  618  618
];
Y1 = [287  287  287  287  287  311  336  362  382  381  365  352  339  327  315  301  288  275  262  250  237  223  211  197  184  170  159  144  130  116  102  99  109  115  121  127  133  139  146  152  158  164  170  175  179  183  187  191  194  198  201  205  208  211  214  218  221  224  227  230  233  235  238  241  244  246  249  251  253  255  258  259  262  264  266  267  269  271  273  274  276  277  278  280  281  282  283  285  286  287  287  288  289  289  290  290  290  291  291  291
];
X2 = [296  296  290  285  279  251  222  191  166  135  144  168  192  216  238  258  278  298  316  334  352  376  396  418  437  460  480  504  526  548  572  594  618  640  664  686  709  732  720  705  692  679  665  652  638  626  613  600  587  575  562  550  538  526  514  502  490  478  467  456  444  432  421  410  399  388  377  366  356  345  334  324  314  304  294  284  273  263  254  244  234  225  218  210  204  196  189  182  175  168  162  154  148  142  139  136  134  132  130  130
];
Y2 = [99  103  152  208  266  302  332  365  388  359  330  303  277  250  225  202  180  157  136  116  99  117  132  145  156  170  181  195  209  222  236  249  263  276  289  303  316  329  344  359  375  390  383  374  366  357  348  340  332  324  315  307  299  292  283  275  268  260  253  245  237  230  223  215  208  201  194  187  180  173  167  160  153  147  140  134  128  121  115  109  103  99  102  105  108  111  113  116  119  122  124  127  129  131  130  129  128  128  128  127
];
X3 = [136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  136  135  133  132  131  130  129  130
];
Y3 = [142  142  143  142  142  143  143  142  142  143  142  142  143  142  143  142  142  143  142  142  142  142  142  142  142  142  143  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  142  143  146  147  149  151  153  153
];
%% Changement des coordonnées pour matlab

Y1 = (height - Y1);
Y2 = (height - Y2);
Y3 = (height - Y3);

%% Normalisation des valeurs RGB

Ballcol = [Rball Gball Bball]./255;
Bandcol = [Rband Gband Bband]./255;

%% Detection des bords

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

%% Calcul du nombre de boules touchées

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
         
    
%% Calcul des distances parcourues par chaque boule    
    
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

%% Détermination du score
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