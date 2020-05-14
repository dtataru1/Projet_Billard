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

height = 480;
width = 854;
% X1-> red, X2->Yellow, X3-> White
%% Initiate the script
clc

%% Changement des coordonnées pour matlab
Y1 = (height - Y1);
Y2 = (height - Y2);
Y3 = (height - Y3);

%% Detection des bords
Xmin = min([X1,X2,X3])
Xmax = max([X1,X2,X3])
Ymin = min([Y1,Y2,Y3])
Ymax = max([Y1,Y2,Y3])

Xframe = [Xmin Xmax Xmax Xmin Xmin];
Yframe = [Ymin Ymin Ymax Ymax Ymin];

figure(1);
hold on
    set(gca,'Color',[0.4,0.4,0.4]);
    plot(Xframe, Yframe,'-b','DisplayName','Bords du billard');
    plot(X1,Y1,'-r','DisplayName','Boule rouge');
    plot(X2,Y2,'-y','DisplayName','Boule jaune');
    plot(X3,Y3,'-w','DisplayName','Boule blanche');
    legend('TextColor', 'white');
    hold off
%% Détection de la premiere balle qui bouge
    
d=2;
distB1 = sqrt(X1.^2+Y1.^2)-sqrt((X1(1)).^2+(Y1(1)).^2);
distB2 = sqrt(X2.^2+Y2.^2)-sqrt((X2(1)).^2+(Y2(1)).^2);
distB3 = sqrt(X3.^2+Y3.^2)-sqrt((X3(1)).^2+(Y3(1)).^2);
    
b1m=find(abs(distB1)>d, 1);
b2m=find(abs(distB2)>d, 1);
b3m=find(abs(distB3)>d, 1);

%plus petit indice de début de mouvement tfirst et numero de la boule ifirst
A=[b1m,b2m,b3m];
[tfirst,ifirst] = min(A)
A(ifirst) = [];
[tsecond, isecond] = min(A);
A(isecond) = [];
tthird = A
if isempty(A) == 1
    fprintf('La balle ne touche pas la 3ème boule');
end

    
%deteciton des rebonds contre les bandes de la balle I
dboule =9;
switch ifirst
    case 1
    XFIRST = X1;
    YFIRST = Y1;
    case 2
    XFIRST = X2;
    YFIRST = Y2;
    case 3
    XFIRST = X3;
    YFIRST = Y3;
end            

    rbndXmin = find(abs(XFIRST(tfirst:end)-Xmin)<= dboule);
    rbndXmax = find(abs(XFIRST(tfirst:end)-Xmax)<= dboule);
    rbndYmin = find(abs(YFIRST(tfirst:end)-Ymin)<= dboule);
    rbndYmax = find(abs(YFIRST(tfirst:end)-Ymax)<= dboule);
    
    rbndYmax = abs(diff([0,rbndYmax]))>1
    rbndYmin = abs(diff([0,rbndYmin]))>1
    rbndXmax = abs(diff([0,rbndXmax]))>1
    rbndXmin = abs(diff([0,rbndXmin]))>1
    
    nbrebonds = size(find(rbndXmax),2) + size(find(rbndYmax),2) + size(find(rbndXmin),2)+size(find(rbndYmin),2)

    
%% Detection des chocs entre les boules
    chocs12 = find(abs(Y2-Y1)<=20 & abs(X2-X1)<=20)
    chocs23 = find(abs(Y3-Y2)<=15 & abs(X3-X2)<=15)
    chocs13 = find(abs(Y3-Y1)<=15 & abs(X3-X1)<=15)
    
    