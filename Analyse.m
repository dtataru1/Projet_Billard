clc, clear, close all;

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
%% Initiate the script


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

X1(OX1id)=X1(OX1id-1);
Y1(OY1id)=Y1(OY1id-1);
X2(OX2id)=X2(OX2id-1);
Y2(OY2id)=Y2(OY2id-1);
X3(OX3id)=X3(OX3id-1);
Y3(OY3id)=Y3(OY3id-1);

figure(1);
hold on
    set(gca,'Color',[0.4,0.4,0.4]);
    plot(Xframe, Yframe,'-*b','DisplayName','Bords du billard');
    plot(X1,Y1,'-*r','DisplayName','Boule rouge');
    plot(X2,Y2,'-*y','DisplayName','Boule jaune');
    plot(X3,Y3,'-*w','DisplayName','Boule blanche');
    legend('TextColor', 'white');
    hold off
%% Détection de la premiere balle qui bouge
    
d=2;
distB1 = sqrt((X1-X1(1)).^2+(Y1-Y1(1)).^2);
distB2 = sqrt((X2-X2(1)).^2+(Y2-Y2(1)).^2);
distB3 = sqrt((X3-X3(1)).^2+(Y3-Y3(1)).^2);
    
b1m=find(abs(distB1)>d, 1);
if isempty(b1m) 
   b1m = size(X1,2)-2;
   fprintf('La balle ne touche pas la 3ème boule');
end
b2m=find(abs(distB2)>d, 1);
if isempty(b2m) 
   b2m = size(X2,2)-2; 
   fprintf('La balle ne touche pas la 3ème boule');
end
b3m=find(abs(distB3)>d, 1);
if isempty(b3m) 
   b3m = size(X3,2)-2;
   fprintf('La balle ne touche pas la 3ème boule');
end
%plus petit indice de début de mouvement tfirst et numero de la boule ifirst

A=[b1m,b2m,b3m];
[tfirst,ifirst] = min(A);

[tthird, ithird] = max(A);

A(ifirst) = [];
tsecond = min(A);

%deteciton des rebonds contre les bandes de la balle I
dboule =9;
switch ifirst
    case 1
    XFIRST = X1;
    YFIRST = Y1;
    switch ithird
        case 2
            XTHIRD = X2;
            YTHIRD = Y2;
            XSECOND = X3;
            YSECOND = Y3;
        case 3
             XTHIRD = X3;
            YTHIRD = Y3;
            XSECOND = X2;
            YSECOND = Y2;
    end
    
    case 2
    XFIRST = X2;
    YFIRST = Y2;
            switch ithird
        case 1
            XSECOND = X3;
            XTHIRD = X1;
            YTHIRD = Y1;
            YSECOND = Y3;
        case 3
            XSECOND = X1;
            XTHIRD = X3;
            YTHIRD = Y3;
            YSECOND = Y1;
            end
    case 3
    XFIRST = X3;
    YFIRST = Y3;
     switch ithird
        case 1
            XSECOND = X2;
            XTHIRD = X1;
            YTHIRD = Y1;
            YSECOND = Y2;
        case 2
            XSECOND = X1;
            XTHIRD = X2;
            YTHIRD = Y2;
            YSECOND = Y1;
    end
end

    rbndXmin = find(abs(XFIRST-Xmin)<= dboule)
    rbndXmax = find(abs(XFIRST-Xmax)<= dboule)
    rbndYmin = find(abs(YFIRST-Ymin)<= dboule)
    rbndYmax = find(abs(YFIRST-Ymax)<= dboule)
 
    rbndXmin = rbndXmin >= tsecond & rbndXmin<=tthird 
    
    rbndYmax = abs(diff([0,rbndYmax]))>1
    rbndYmin = abs(diff([0,rbndYmin]))>1
    rbndXmax = abs(diff([0,rbndXmax]))>1
    rbndXmin = abs(diff([0,rbndXmin]))>1
    
    nbrebonds = size(find(rbndXmax),2) + size(find(rbndYmax),2) + size(find(rbndXmin),2)+size(find(rbndYmin),2)

    
%% Detection des chocs entre les boules   

chocs12 = find(abs(YFIRST(tsecond-2:tsecond+2)-YSECOND(tsecond-2:tsecond+2))<=35 & abs(XFIRST(tsecond-2:tsecond+2)-XSECOND(tsecond-2:tsecond+2))<=35);
  
chocs13 = find(abs(YFIRST(tthird-2:tthird+2)-YTHIRD(tthird-2:tthird+2))<=35 & abs(XFIRST(tthird-2:tthird+2)-XTHIRD(tthird-2:tthird+2))<=35);
    
if isempty(chocs12) == 1
    fprintf('pas de choc sur');
else
    fprintf('choc sur photo %d\n',tsecond);
end

if isempty(chocs13) == 1
    fprintf('pas de choc sur');
else
    fprintf('choc sur photo %d\n',tthird);
end


%% Sauvegarde de la figure

saveas(figure(1),'ScoreSheet.pdf');


