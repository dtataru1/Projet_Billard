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
void ball_score (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], pixelscore ballscore[], int whiterange[], int yellowrange[], int redrange[], int bluerange[]);
struct coord ball_coord (int C, int Lmin, int Lmax, int Cmin, int Cmax, pixelscore ballscore[]);

int main (int argc, char *argv[]) {
    
    if(argc!=30) {
        fprintf(stderr, "Il n'y a pas le bon nombre de paramètres dans la ligne de commandes.\n");
        return -1;
    }
    
    //Reading the input arguments
    int Lmin, Lmax, Cmin, Cmax, balldiameter;
    Lmin = atoi(argv[1]);
    Lmax = atoi(argv[2]);
    Cmin = atoi(argv[3]);
    Cmax = atoi(argv[4]);
    balldiameter = atoi(argv[29]);
    if (balldiameter>20|| balldiameter<5) {
        fprintf(stderr, "Le diamètre de la balle est en dehors des bornes.\n");
        return -1;
    }
    
    //Initiating color ranges arrays, as follows : Rmin Rmax Gmin Gmax Bmin Bmax
    int whiterange[6], yellowrange[6], redrange[6], bluerange[6];
    
    for (int i=5; i<11; i++) redrange[i-5] = atoi(argv[i]);
    for (int i=11; i<17; i++) yellowrange[i-11] = atoi(argv[i]);
    for (int i=17; i<23; i++) whiterange[i-17] = atoi(argv[i]);
    for (int i=23; i<29; i++) bluerange[i-23] = atoi(argv[i]);
    
    
    //Reading the Pixmap file
    FILE* Pixmap = NULL;
    Pixmap = fopen("Pixmap.bin", "rb");
    if (Pixmap == NULL) {
        fprintf(stderr, "Impossilbe de lire le fichier Pixmap.bin.\n");
        return -1;
    }
    
    unsigned int L, C;
    fread(&C, sizeof C, 1, Pixmap);
    fread(&L, sizeof L, 1, Pixmap);

    if(L<10 || L>1000 || C<10|| C>1000) {
        fprintf(stderr, "La largeur et/ou hauteur sont en dehors des bornes.\n");
        return -1;
    }
    
    unsigned int* pixels = NULL;
    pixels = malloc(L *  C * sizeof(unsigned int));
    
    if (pixels==NULL) {
        fprintf(stderr, "Imppossible d'allouer la mémoire.\n");
        return -1;
    }
    
    size_t nbrelus = fread(pixels, sizeof(unsigned int), L*C, Pixmap);

    if(nbrelus<L*C) {
        fprintf(stderr, "Il n'y a pas assez de pixels dans le fichier Pixmap.bin.\n");
        return -1;
    }
    fclose(Pixmap);
    
    color* ballcolor = NULL;
    ballcolor = malloc(L*C*sizeof(color));
    pixelscore*  ballscore = NULL;
    ballscore = malloc(L*C*sizeof(pixelscore));
    if (ballscore==NULL || ballcolor==NULL) {
        fprintf(stderr, "Imppossible d'allouer la mémoire.\n");
        return -1;
    }
    
    //Converting to RGB and determining the coordinates of the three balls
    ball_color(C, Lmin, Lmax, Cmin, Cmax, ballcolor, pixels);
    ball_score(C, Lmin, Lmax, Cmin, Cmax, ballcolor, ballscore, whiterange, yellowrange, redrange, bluerange);
    coord coordinates = ball_coord(C, Lmin, Lmax, Cmin, Cmax, ballscore);
    
    //Error management
    if (coordinates.whitescore == 0 || coordinates.redscore == 0 || coordinates.yellowscore == 0) {
         fprintf(stderr, "Il y a moins de 3 boules sur le tapis.\n");
         return -1;
     }
     
   if((abs(coordinates.whitex-coordinates.yellowx)<11 && abs(coordinates.whitey-coordinates.yellowy)<11) || (abs(coordinates.whitex-coordinates.redx)<11 && abs(coordinates.whitey-coordinates.redy)<11)
       || (abs(coordinates.redx-coordinates.yellowx)<11 && abs(coordinates.redy-coordinates.yellowy)<11)) {
        fprintf(stderr, "Au moins deux des boules se superposent.\n");
        return 0;
    }
    
    FILE* Pos = NULL;
    Pos = fopen("Pos.txt", "w");
    if (Pos==NULL) {
        fprintf(stderr, "Impossible de créer, ouvrir ou écrire dans le fichier Pos.txt.\n");
        return -1;
    }
    
    fprintf(Pos, "Red: %d, %d, %d\nYellow: %d, %d, %d\nWhite: %d, %d, %d", coordinates.redx, coordinates.redy, coordinates.redscore, coordinates.yellowx, coordinates.yellowy, coordinates.yellowscore, coordinates.whitex, coordinates.whitey, coordinates.whitescore);
    fclose(Pos);
    
    free(pixels);
    free(ballcolor);
    free(ballscore);
    return 0;
}

//Converting from Hexadecimal to RGB
void ball_color (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], unsigned int pixel[]) {
    for (int i=Lmin; i<Lmax; i++) {
        for (int j=Cmin; j<Cmax; j++) {
            ballcolor[i*C+j].red = (pixel[i*C+j] & 0x00FF0000) >> 16;
            ballcolor[i*C+j].green = (pixel[i*C+j] & 0x0000FF00) >> 8;
            ballcolor[i*C+j].blue = (pixel[i*C+j] & 0x000000FF);
        }
    }
}


//Calculating the scores of a 11 by 11 square for each pixel
void ball_score (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], pixelscore ballscore[], int whiterange[], int yellowrange[], int redrange[], int bluerange[]) {
    for (int i=Lmin; i<=Lmax-11; i++) {
        
        //Initialisation des scores à 0 pour chaque pixel
        for (int k=Cmin; k<Cmax; k++) {
            ballscore[i*C+k].white = 0;
            ballscore[i*C+k].yellow = 0;
            ballscore[i*C+k].red = 0;
        }
        
        for (int j=Cmin; j<=Cmax-11; j++) {
            while(ballcolor[(i+5)*C+j+5].red>=bluerange[0] && ballcolor[(i+5)*C+j+5].red<=bluerange[1] && ballcolor[(i+5)*C+j+5].green>=bluerange[2] && ballcolor[(i+5)*C+j+5].green<=bluerange[3] && ballcolor[(i+5)*C+j+5].blue>=bluerange[4] && ballcolor[(i+5)*C+j+5].blue<=bluerange[5]){
                j++;
            }
            for (int k=i;k<i+11;k++) {
                for(int l=j;l<j+11;l++) {
                    
                    //White ball score count
                    if(ballcolor[k*C+l].red>=whiterange[0] && ballcolor[k*C+l].red<=whiterange[1] && ballcolor[k*C+l].green>=whiterange[2] && ballcolor[k*C+l].green<=whiterange[3] && ballcolor[k*C+l].blue>=whiterange[4] && ballcolor[k*C+l].blue<=whiterange[5]) ballscore[i*C+j].white++;

                    //Yellow ball score count
                    if(ballcolor[k*C+l].red>=yellowrange[0] && ballcolor[k*C+l].red<=yellowrange[1] && ballcolor[k*C+l].green>=yellowrange[2] && ballcolor[k*C+l].green<=yellowrange[3] && ballcolor[k*C+l].blue>=yellowrange[4] && ballcolor[k*C+l].blue<=yellowrange[5]) ballscore[i*C+j].yellow++;
                        
                    //Red ball score count
                    if(ballcolor[k*C+l].red>=redrange[0] && ballcolor[k*C+l].red<=redrange[1] && ballcolor[k*C+l].green>=redrange[2] && ballcolor[k*C+l].green<=redrange[3] && ballcolor[k*C+l].blue>=redrange[4] && ballcolor[k*C+l].blue<=redrange[5]) ballscore[i*C+j].red++;
                }
            }
        }
    }
}

//Determining the coordinates
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
