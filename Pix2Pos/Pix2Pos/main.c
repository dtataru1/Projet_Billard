#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct color {
    int red;
    int green;
    int blue;
} color;

typedef struct pixelscore {
    int white;
    int yellow;
    int red;
} pixelscore;

typedef struct coord{
    int whitex;
    int whitey;
    int whitescore;
    int yellowx;
    int yellowy;
    int yellowscore;
    int redx;
    int redy;
    int redscore;
}coord;


void ball_color (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], unsigned int pixel[]);
void ball_score (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], pixelscore ballscore[], int whiterange[], int yellowrange[], int redrange[]);
struct coord ball_coord (int C, int Lmin, int Lmax, int Cmin, int Cmax, pixelscore ballscore[]);

int main (int argc, char *argv[]) {
    
    if(argc!=30) {
        printf("Il n'y a pas le bon nombre de paramètres dans la ligne de commandes\n");
        return -1;
    }
    
    int Lmin, Lmax, Cmin, Cmax, balldiameter;
    Lmin = atoi(argv[1]);
    Lmax = atoi(argv[2]);
    Cmin = atoi(argv[3]);
    Cmax = atoi(argv[4]);
    balldiameter = atoi(argv[29]);
    if (balldiameter>20|| balldiameter<5) {
        printf("Le diamètre de la balle est en dehors des bornes\n");
        return -1;
    }
    
    int whiterange[6], yellowrange[6], redrange[6], bluerange[6];  //toujours minred maxred mingreen maxgreen minblue maxblue;
    
    for (int i=5; i<11; i++) redrange[i-5] = atoi(argv[i]);
    for (int i=11; i<17; i++) yellowrange[i-11] = atoi(argv[i]);
    for (int i=17; i<23; i++) whiterange[i-17] = atoi(argv[i]);
    for (int i=23; i<29; i++) bluerange[i-23] = atoi(argv[i]);
    
    FILE* Pixmap = NULL;
    Pixmap = fopen("Pixmap.bin", "rb");
    if (Pixmap == NULL) {
        perror("Impossilbe de lire le fichier Pixmap.bin\n");
        return -1;
    }
    
    unsigned int L, C;
    fread(&C, sizeof C, 1, Pixmap);
    fread(&L, sizeof L, 1, Pixmap);
    printf("C = %d\nL = %d\n", C, L);
    if(L<10 || L>1000 || C<10|| C>1000) {
        printf("La largeur et/ou hauteur sont en dehors des bornes\n");
        return -1;
    }
    
    unsigned int* pixels = NULL;
    pixels = malloc(L *  C * sizeof(unsigned int));
    
    if (pixels==NULL) exit(0);
    
    size_t nbrelus = fread(pixels, sizeof(unsigned int), L*C, Pixmap);

    if(nbrelus<L*C) {
        printf("Il n'y a pas assez de pixels dans le fichier Pixmap.bin\n");
        return -1;
    }
    fclose(Pixmap);
    
    color* ballcolor = NULL;
    ballcolor = malloc(L*C*sizeof(color));
    if (ballcolor==NULL) exit(0);
    pixelscore*  ballscore = NULL;
    ballscore = malloc(L*C*sizeof(pixelscore));
    if (ballscore==NULL) exit(0);
    
    ball_color(C, Lmin, Lmax, Cmin, Cmax, ballcolor, pixels);
    ball_score(C, Lmin, Lmax, Cmin, Cmax, ballcolor, ballscore, whiterange, yellowrange, redrange);
    coord coordinates = ball_coord(C, Lmin, Lmax, Cmin, Cmax, ballscore);

    printf("\n White coordinates : x = %d  y = %d  score = %d\n", coordinates.whitex, coordinates.whitey, coordinates.whitescore);
    printf("\n Yellow coordinates : x = %d y = %d score = %d\n", coordinates.yellowx, coordinates.yellowy, coordinates.yellowscore);
    printf("\n Red coordinates : x = %d y = %d score = %d\n", coordinates.redx, coordinates.redy, coordinates.redscore);
    
    if (coordinates.whitescore == 0 || coordinates.redscore == 0 || coordinates.yellowscore == 0) {
         printf("Il y a moins de 3 boules sur le tapis\n");
         return -1;
     }
     
   if((abs(coordinates.whitex-coordinates.yellowx)<11 && abs(coordinates.whitey-coordinates.yellowy)<11) || (abs(coordinates.whitex-coordinates.redx)<11 && abs(coordinates.whitey-coordinates.redy)<11)
       || (abs(coordinates.redx-coordinates.yellowx)<11 && abs(coordinates.redy-coordinates.yellowy)<11)) {
        printf("Au moins deux des boules se superposent\n");
        return -1;
    }
    
 
    
    
  /*  for(int i=coordinates.whitex+1; i<Lmax; i++) {
           for(int j=coordinates.whitey; j<Cmax; j++) {
               
               if (ballscore[i*C+j].white==coordinates.whitescore) {
                   printf("Il y a deux boules blanches sur le tapis\n");
                   return -1;
               }
           }
    }
    
    for(int i=coordinates.yellowx+1; i<Lmax; i++) {
           for(int j=coordinates.yellowy; j<Cmax; j++) {
               
               if (ballscore[i*C+j].yellow==coordinates.yellowscore) {
                   printf("Il y a deux boules jaunes sur le tapis\n");
                   return -1;
               }
           }
    }

    for(int i=coordinates.redx+1; i<Lmax; i++) {
           for(int j=coordinates.redy; j<Cmax; j++) {
               
               if (ballscore[i*C+j].red==coordinates.redscore) {
                   printf("Il y a deux boules rouges sur le tapis\n");
                   return -1;
               }
           }
    }
    */
    
    FILE* Pos = NULL;
    Pos = fopen("Pos.txt", "w");
    if (Pos==NULL) {
        perror("Impossible de créer, ouvrir ou écrire dans le fichier Pos.txt\n");
        return -1;
    }
    
    fprintf(Pos, "Red: %d, %d, %d\nYellow: %d, %d, %d\nWhite: %d, %d, %d", coordinates.redx, coordinates.redy, coordinates.redscore, coordinates.yellowx, coordinates.yellowy, coordinates.yellowscore, coordinates.whitex, coordinates.whitey, coordinates.whitescore);
    fclose(Pos);
    
    
    
    free(pixels);
    free(ballcolor);
    free(ballscore);
    return 0;
}

void ball_color (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], unsigned int pixel[]) {
    for (int i=Lmin; i<Lmax; i++) {
        for (int j=Cmin; j<Cmax; j++) {
            ballcolor[i*C+j].red = (pixel[i*C+j] & 0x00FF0000) >> 16;
            ballcolor[i*C+j].green = (pixel[i*C+j] & 0x0000FF00) >> 8;
            ballcolor[i*C+j].blue = (pixel[i*C+j] & 0x000000FF);
        }
    }
}


//Determination du score par carré de onze
void ball_score (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], pixelscore ballscore[], int whiterange[], int yellowrange[], int redrange[]) {
    for (int i=Lmin; i<=Lmax-11; i++) {
        
        //Initialisation des scores à 0 pour chaque pixel
        for (int k=Cmin; k<Cmax; k++) {
            ballscore[i*C+k].white = 0;
            ballscore[i*C+k].yellow = 0;
            ballscore[i*C+k].red = 0;
        }
        
        for (int j=Cmin; j<=Cmax-11; j++) {
            
            for (int k=i;k<i+11;k++) {
                for(int l=j;l<j+11;l++) {
                    
                    //Compteur du score boule blanche
                    if(ballcolor[k*C+l].red>=whiterange[0] && ballcolor[k*C+l].red<=whiterange[1] && ballcolor[k*C+l].green>=whiterange[2] && ballcolor[k*C+l].green<=whiterange[3] && ballcolor[k*C+l].blue>=whiterange[4] && ballcolor[k*C+l].blue<=whiterange[5]) ballscore[i*C+j].white++;

                    //Compteur du score boule jaune
                    if(ballcolor[k*C+l].red>=yellowrange[0] && ballcolor[k*C+l].red<=yellowrange[1] && ballcolor[k*C+l].green>=yellowrange[2] && ballcolor[k*C+l].green<=yellowrange[3] && ballcolor[k*C+l].blue>=yellowrange[4] && ballcolor[k*C+l].blue<=yellowrange[5]) ballscore[i*C+j].yellow++;
                        
                    //Compteur du score boule rouge
                    if(ballcolor[k*C+l].red>=redrange[0] && ballcolor[k*C+l].red<=redrange[1] && ballcolor[k*C+l].green>=redrange[2] && ballcolor[k*C+l].green<=redrange[3] && ballcolor[k*C+l].blue>=redrange[4] && ballcolor[k*C+l].blue<=redrange[5]) ballscore[i*C+j].red++;
                }
            }
        }
    }
}

//Détermination des coordonnées des boules
struct coord ball_coord (int C, int Lmin, int Lmax, int Cmin, int Cmax, pixelscore ballscore[]) {
    
    struct coord coordinates = {0, 0, 0, 0, 0, 0, 0, 0, 0} ;
    
    for(int i=Lmin; i<Lmax; i++) {
        for(int j=Cmin; j<Cmax; j++) {
            
            if (ballscore[i*C+j].white>coordinates.whitescore) {
                coordinates.whitescore=ballscore[i*C+j].white;
                coordinates.whitex=j;
                coordinates.whitey=i;
            }
      

            if (ballscore[i*C+j].yellow>coordinates.yellowscore) {
            coordinates.yellowscore=ballscore[i*C+j].yellow;
            coordinates.yellowx=j;
            coordinates.yellowy=i;
            }
        
    
            if (ballscore[i*C+j].red>coordinates.redscore) {
            coordinates.redscore=ballscore[i*C+j].red;
            coordinates.redx=j;
            coordinates.redy=i;
            }
        }
    }
    return coordinates;
}
