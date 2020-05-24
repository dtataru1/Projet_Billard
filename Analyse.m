clc, clear, close all;

X1 = [656  656  656  656  656  656  656  656  656  656  656  656  656  656  646  624  605  589  572  557  540  524  508  492  476  461  445  429  413  398  383  368  353  341  330  319  308  297  286  275  265  254  244  233  223  213  202  192  183  173  163  153  143  134  132  138  143  149  154  159  164  169  174  178  183  188  193  198  202  206  210  215  219  223  228  231  235  239  243  246  250  253  257  260  263  267  270  273  276  278  281  284  287  289  291  294  297  299  301  303  305  308  309  311  312  315  316  318  319  320  322  322  324  325  326  326  327  329  329  329  330  330  330  331  331  331  332  332  332  332  332  333
];
Y1 = [152  152  152  152  152  152  152  152  152  152  152  152  152  152  161  177  192  205  219  231  244  257  270  283  295  308  320  333  344  357  369  381  389  381  375  369  363  357  352  346  340  334  329  323  317  313  307  301  296  291  285  280  275  270  266  261  256  252  247  243  239  235  231  227  223  219  215  211  208  205  201  197  194  190  187  184  181  178  174  171  169  166  163  160  157  155  152  149  147  145  143  141  138  136  134  133  130  128  127  125  123  121  120  119  117  116  115  113  112  111  110  109  108  107  106  106  105  104  104  103  103  102  101  101  101  101  101  100  100  100  100  100
];
X2 = [667  667  667  667  667  667  667  667  667  667  667  667  667  667  677  698  716  732  725  716  708  698  682  665  650  634  620  604  590  576  561  546  532  518  504  490  476  468  460  452  444  436  427  419  412  404  396  388  380  374  366  358  351  344  336  329  322  316  308  302  294  288  282  274  268  262  255  248  242  236  230  224  218  212  206  200  194  188  184  179  175  171  167  163  160  156  152  148  144  141  138  134  132  128  129  131  133  134  136  138  139  140  142  144  144  146  146  148  148  149  150  150  151  152  152  152  152  153  153  154  154  154  154  154  154  154  154  154  154  154  154  154
];
Y2 = [100  100  100  100  100  100  100  100  100  100  100  100  100  114  160  193  227  261  295  332  368  386  359  333  312  293  275  256  239  221  203  185  168  150  133  116  100  108  118  127  135  143  151  159  167  175  183  191  198  206  214  221  229  236  243  250  258  265  272  278  285  292  299  305  312  318  325  331  338  344  350  356  362  368  374  379  385  390  387  384  381  378  376  373  370  367  365  362  360  358  355  353  350  348  346  345  342  341  339  337  336  334  332  331  330  328  327  326  325  323  322  321  320  320  319  318  317  317  317  316  316  315  315  315  315  315  315  315  315  315  315  315
];
X3 = [131  131  130  130  130  130  130  130  130  130  130  130  130  130  130  130  131  131  131  131  131  131  131  131  131  131  131  131  131  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  131  131  131  131  131  131  131  131  131  131  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  131  131  131  131  131  131  131  131  131  131  131  130  130  130  130  130  130  130  130  130  130  130  130  131  130  131  131  131  131  131  131  131  131  130  131  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130  130
];
Y3 = [321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321  321
];


% X1-> red, X2->Yellow, X3-> White

%% Changement des coordonn�es pour matlab
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
    set(gca,'Color',[0,0,0.4]);
    plot(Xframe, Yframe,'-b','DisplayName','Bords du billard','LineWidth',4);
    plot(X1,Y1,'.-r','DisplayName','Boule rouge');
    plot(X2,Y2,'.-y','DisplayName','Boule jaune');
    plot(X3,Y3,'.-w','DisplayName','Boule blanche');
    legend('TextColor', 'white');

%% D�tection de la premiere balle qui bouge
    
d=2;
distB1 = sqrt((X1-X1(1)).^2+(Y1-Y1(1)).^2);
distB2 = sqrt((X2-X2(1)).^2+(Y2-Y2(1)).^2);
distB3 = sqrt((X3-X3(1)).^2+(Y3-Y3(1)).^2);
    
mb1=find(distB1>d, 1);
mb2=find(distB2>d, 1);
mb3=find(distB3>d, 1);
touch = 1;
if isempty(mb1) 
   mb1 = size(X1,2);
   fprintf('La balle ne touche pas la 3�me boule');
   touch = 0;
end
if isempty(mb2) 
   mb2 = size(X2,2); 
   fprintf('La balle ne touche pas la 3�me boule');
      touch = 0;

end
if isempty(mb3) 
   mb3 = size(X3,2);
   fprintf('La balle ne touche pas la 3�me boule');
      touch = 0;

end

%plus petit indice de d�but de mouvement tfirst et numero de la boule ifirst

A=[mb1,mb2,mb3];
[tfirst,ifirst] = min(A);
[tthird, ithird] = max(A);
A(ifirst) = [];
tsecond = min(A);

%deteciton des rebonds contre les bandes de la balle I
dboule = 15;

switch ifirst
    case 1
    XFIRST = X1;
    YFIRST = Y1;
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
    rbndXmin = rbndXmin(rbndXmin >= tsecond & rbndXmin<=tthird & abs(diff([0,rbndXmin]))>1);
    
    rbndXmax = find(abs(XFIRST-Xmax)<= dboule);
    rbndXmax = rbndXmax(rbndXmax >= tsecond & rbndXmax<=tthird & abs(diff([0,rbndXmax]))>1);
    
    rbndYmin = find(abs(YFIRST-Ymin)<= dboule);
    rbndYmin = rbndYmin(rbndYmin >= tsecond & rbndYmin<=tthird & abs(diff([0,rbndYmin]))>1);
    
    rbndYmax = find(abs(YFIRST-Ymax)<= dboule);
    rbndYmax = rbndYmax(rbndYmax >= tsecond & rbndYmax<=tthird & abs(diff([0,rbndYmax]))>1);
    
    
    nbrebonds = size(find(rbndXmax),2) + size(find(rbndYmax),2) + size(find(rbndXmin),2)+size(find(rbndYmin),2)

       
        plot(XFIRST(rbndXmin),YFIRST(rbndXmin),'*','MarkerSize',15);
        plot(XFIRST(rbndXmax),YFIRST(rbndXmax),'*','MarkerSize',15);
        plot(XFIRST(rbndYmin),YFIRST(rbndYmin),'*','MarkerSize',15);
        plot(XFIRST(rbndYmax),YFIRST(rbndYmax),'*','MarkerSize',15);
        
    
    hold off
%% Detection des chocs entre les boules   

chocs12 = find(abs(YFIRST(tsecond)-YSECOND(tsecond))<=35 & abs(XFIRST(tsecond)-XSECOND(tsecond))<=35);
  
chocs13 = find(abs(YFIRST(tthird)-YTHIRD(tthird))<=35 & abs(XFIRST(tthird)-XTHIRD(tthird))<=35);
    
if isempty(chocs12) == 1
    fprintf('pas de choc sur');
else
    fprintf('choc sur photo %d\n',tsecond);
end

if isempty(chocs13) == 1 | touch == 0;

    fprintf('pas de choc sur');
else
    fprintf('choc sur photo %d\n',tthird);
end


%% Sauvegarde de la figure

saveas(figure(1),'ScoreSheet.pdf');


