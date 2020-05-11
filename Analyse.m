

% Changement des coordonnées pour matlab
 top=300;
Y1 = (top - Y1);
Y2 = (top - Y2);
Y3 = (top - Y3);

%detection des bords

Xmin = min([X1,X2,X3]);
Xmax = max([X1,X2,X3]);
Ymin = min([Y1,Y2,Y3]);
Ymax = max([Y1,Y2,Y3]);


%Détection de la premiere balle qui bouge
    
    %indice auquel chaque boule commence a bouger
   d=10;
    distB1 = X1.^2+Y1^2-((X1(1)).^2+(Y1(1)).^2);
    distB2 = X2.^2+Y2^2-((X2(1)).^2+(Y2(1)).^2);
    distB3 = X3.^2+Y3^2-((X3(1)).^2+(Y3(1)).^2);
    
    b1m=find(distB1>d, 1 );
    b2m=find(distB2>d, 1 );
    b3m=find(distB3>d, 1 );

    %plus petit indice de début de mouvement (M) et numero de la boule
    %correspondante (I)
    
    A=[b1m,b2m,b3m];
    [M,I]=min(A);

    

%deteciton des rebonds contre les bandes de la balle I

idXmax1 = find(abs(XI-Xmax)<= Rayon);
idYmax1 = find(abs(YI-Ymax)<= Rayon);
idXmin1 = find(abs(XI-Xmin)<= Rayon);
idYmin1 = find(abs(YI-Ymin)<= Rayon);

nbrebonds = size(idXmax1) + size(idYmax1) + size(idXmin1) + size(idYmin1);


%detection des chocs entre les boules

    
    