clc, clear, close all
Folder = 'F2';

X1 = [284  284  284  284  284  284  213  131  186  246  301  354  405  451  497  542  587  633  679  725  708  671  639  609  583  558  533  508  483  458  433  409  385  361  337  313  289  265  243  219  196  173  149  129  146  162  175  189  202  215  227  239  252  265  277  288  301  313  325  337  347  359  371  382  393  404  415  426  437  448  458  468  479  489  500  509  519  529  539  549  559  568  577  587  596  605  614  623  632  641  650  658  667  675  684  692  700  708  716  724  731  733  729  724  720  716  712  708  704  701  697
];
Y1 = [354  354  354  354  354  354  346  345  343  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  341  340  340  340  340  340  340  340  340  340  339  339  339  339  338  338  338  338  338  337  337  337  337  336  336  336  336  336  336  336  336  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  335  336  336
];
X2 = [130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  129  129  129  129  129  129  129  129  130  130  132  132  134  134  135  136  137  137  138  139  140  140  142  141  142  142  143  144  144  144  144  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  145  145  145  145  145  145  145  145
];
Y2 = [262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  262  266  269  273  276  279  282  285  288  290  293  296  298  301  303  305  307  309  311  312  314  316  318  319  320  321  322  323  325  325  326  327  327  328  329  329  329  329  330  330  330  329  329  329  329  329  329  329  329  329  329  329  329  329  329  329  329
];
X3 = [597  597  597  521  404  308  291  287  281  273  264  260  256  250  243  234  223  213  202  196  192  188  184  179  175  171  167  163  158  154  150  147  142  138  134  131  130  130  130  130  130  131  131  131  131  131  132  131  131  132  132  132  132  133  133  134  136  137  139  140  142  143  144  145  146  147  148  149  150  151  152  153  153  153  154  154  155  155  155  155  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156  156
];
Y3 = [121  121  121  181  272  346  381  291  226  165  110  126  169  209  246  280  315  345  378  375  352  332  314  297  280  263  246  230  213  196  180  165  148  132  116  101  107  116  125  134  142  150  158  166  175  182  190  198  205  213  220  228  235  242  249  251  253  254  256  258  259  261  262  263  264  266  267  268  269  270  271  271  272  273  273  274  274  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275  275
];



% X1-> red, X2->Yellow, X3-> White

%% Changement des coordonnées pour matlab
height = 480;
width = 854;
Y1 = (height - Y1);
Y2 = (height - Y2);
Y3 = (height - Y3);


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
   fprintf('La balle ne touche pas la 3ème boule');
   touch = touch - 1;
end
if isempty(mb2) 
   mb2 = size(X2,2)-2; 
   fprintf('La balle ne touche pas la 3ème boule');
      touch = touch - 1;

end
if isempty(mb3) 
   mb3 = size(X3,2)-2;
   fprintf('La balle ne touche pas la 3ème boule');
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
    player = 'Score sheet for "Red" ';
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
    player = 'Score sheet for "Yellow" ';
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
    player = 'Score sheet for "White" ';
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

chocs12 = find(abs(YFIRST(tsecond-2:tsecond+2)-YSECOND(tsecond-2:tsecond+2))<=35 & abs(XFIRST(tsecond-2:tsecond+2)-XSECOND(tsecond-2:tsecond+2))<=35);
  
chocs13 = find(abs(YFIRST(tthird)-YTHIRD(tthird))<=35 & abs(XFIRST(tthird)-XTHIRD(tthird))<=35);
    
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
    score = 'Win';
else
    score = 'Lose';
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
    plot(X1,Y1,'.-r','DisplayName','Boule rouge');
    plot(X2,Y2,'.-y','DisplayName','Boule jaune');
    plot(X3,Y3,'.-k','DisplayName','Boule blanche');
    plot(XFIRST(rbndXmin),YFIRST(rbndXmin),'.m','MarkerSize',15);
    plot(XFIRST(rbndXmax),YFIRST(rbndXmax),'.m','MarkerSize',15);
    plot(XFIRST(rbndYmin),YFIRST(rbndYmin),'.m','MarkerSize',15);
    plot(XFIRST(rbndYmax),YFIRST(rbndYmax),'.m','MarkerSize',15);
    
    text(Xmin, 70, player);
    text(Xmin+50, 50, score);
    text(Xmax-250, 80, ['Number of balls touched : ',num2str(touch)]);
    text(Xmax-250, 65, ['Number of bands touched : ',num2str(nbrebonds)]);
    text(Xmax-300, 50, ['Number of bands touched between balls : ',num2str(rebondsentre)]);
    text(Xmin, 20, ['Dist(r) : ',num2str(DistR)]);
    text(Xmin+200, 20, ['Dist(y) : ',num2str(DistY)]);
    text(Xmin+400, 20, ['Dist(w) : ',num2str(DistW)]);
    
             
    
%% Sauvegarde de la figure

print('ScoreSheet','-dpdf');
hold off

