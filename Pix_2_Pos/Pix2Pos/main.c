/*
    main.c File for Pix2Pos
    
    Group : Axel Rossettini   SCIPER: 303157
            Daniel Tataru     SCIPER: 301005
            Ellie Tupin       SCIPER: 296441
 
 
 
    This file is divided in three parts: declaration of structures and function prototypes
                                         main function
                                         other functions
 
    Revision:
            03.2020 Initial release
            04.2020 Error management
            05.2020 Final modifications
 
    Coded using XCode 11.4.1 for macOS
 
    All errors will print a message in stderr
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// Structure declaration for each pixel to contain the color/the pixelscore for each ball and a structure containing the coordinates
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


//Function prototypes (see below main function)
void BallColor (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], unsigned int pixel[]);
void BallScore (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], pixelscore ballscore[], int whiterange[], int yellowrange[], int redrange[], int bluerange[]);
struct coord BallCoord (int C, int Lmin, int Lmax, int Cmin, int Cmax, pixelscore ballscore[]);

int main (int argc, char *argv[]) {
    
    //In case of incorrect number of program arguments the program stops
    if(argc!=30) {
        fprintf(stderr, "Il n'y a pas le bon nombre de paramètres dans la ligne de commandes.\n");
        return -1;
    }
    
    //Reading the input arguments and converting them to integers
    int Lmin, Lmax, Cmin, Cmax, balldiameter;
    Lmin = atoi(argv[1]);
    Lmax = atoi(argv[2]);
    Cmin = atoi(argv[3]);
    Cmax = atoi(argv[4]);
    balldiameter = atoi(argv[29]);
    
    //In case of incorrect ball diameter, the program stops
    if (balldiameter>20|| balldiameter<5) {
        fprintf(stderr, "Le diametre de la balle est en dehors des bornes.\n");
        return -1;
    }
    
    //Initiating color ranges arrays, as follows : Rmin Rmax Gmin Gmax Bmin Bmax for the three balls and the blue background
    int whiterange[6], yellowrange[6], redrange[6], bluerange[6];
    
    for (int i=5; i<11; i++) redrange[i-5] = atoi(argv[i]);
    for (int i=11; i<17; i++) yellowrange[i-11] = atoi(argv[i]);
    for (int i=17; i<23; i++) whiterange[i-17] = atoi(argv[i]);
    for (int i=23; i<29; i++) bluerange[i-23] = atoi(argv[i]);
    
    
    //Reading the Pixmap file
    FILE* Pixmap = NULL;
    Pixmap = fopen("Pixmap.bin", "rb");
    
    //In case of unability to read, the program stops
    if (Pixmap == NULL) {
        fprintf(stderr, "Impossilbe de lire le fichier Pixmap.bin.\n");
        return -1;
    }
    
    //Reading the first two values of the Pixmap: height(L) and then width(C)
    unsigned int L, C;
    fread(&C, sizeof C, 1, Pixmap);
    fread(&L, sizeof L, 1, Pixmap);
    
    //If the first two values are incorrect, the program stops
    if(L<10 || L>1000 || C<10|| C>1000) {
        fprintf(stderr, "La largeur et/ou hauteur sont en dehors des bornes.\n");
        return -1;
    }
    
    //Initiating the pxiel arrray by allocating memory
    unsigned int* pixels = NULL;
    pixels = malloc(L *  C * sizeof(unsigned int));
    
    //In case of malloc error
    if (pixels==NULL) {
        fprintf(stderr, "Imppossible d'allouer la memoire.\n");
        return -1;
    }
    
    //Reading the remaining values of Pixmap and filling up the pixels array
    size_t nbrelus = fread(pixels, sizeof(unsigned int), L*C, Pixmap);

    //In case of insufficient pixels, the program stops (if there are more pixels than needed, we ignore the overflow pixels)
    if(nbrelus<L*C) {
        fprintf(stderr, "Il n'y a pas assez de pixels dans le fichier Pixmap.bin.\n");
        return -1;
    }
    fclose(Pixmap);
    
    //Allocating memory for the arrays containing the colors of each pixel in RGB format and the score for each pixel of each ball
    color* ballcolor = NULL;
    ballcolor = malloc(L*C*sizeof(color));
    pixelscore*  ballscore = NULL;
    ballscore = malloc(L*C*sizeof(pixelscore));
    
    //In case of insufficient memory, the program stops
    if (ballscore==NULL || ballcolor==NULL) {
        fprintf(stderr, "Imppossible d'allouer la memoire.\n");
        return -1;
    }
    
    //Converting to RGB and determining the coordinates of the three balls
    BallColor(C, Lmin, Lmax, Cmin, Cmax, ballcolor, pixels);
    BallScore(C, Lmin, Lmax, Cmin, Cmax, ballcolor, ballscore, whiterange, yellowrange, redrange, bluerange);
    coord coordinates = BallCoord(C, Lmin, Lmax, Cmin, Cmax, ballscore);
    
    //In case there are less than 3 balls detected, the program stops
    if (coordinates.whitescore == 0 || coordinates.redscore == 0 || coordinates.yellowscore == 0) {
         fprintf(stderr, "Il y a moins de 3 boules sur le tapis.\n");
         return -1;
     }
     
    //In case two of the balls are overlapping, a message is displayed but the program doesn't stop in order to generate the Pos.txt file
   if((abs(coordinates.whitex-coordinates.yellowx)<11 && abs(coordinates.whitey-coordinates.yellowy)<11) || (abs(coordinates.whitex-coordinates.redx)<11 && abs(coordinates.whitey-coordinates.redy)<11)
       || (abs(coordinates.redx-coordinates.yellowx)<11 && abs(coordinates.redy-coordinates.yellowy)<11)) {
        fprintf(stderr, "Au moins deux des boules se superposent.\n");
    }
    
    //Creating the Pos.txt file (stopping the program in case of error) and writing the ball coordinates
    FILE* Pos = NULL;
    Pos = fopen("Pos.txt", "w");
    if (Pos==NULL) {
        fprintf(stderr, "Impossible de creer, ouvrir ou ecrire dans le fichier Pos.txt.\n");
        return -1;
    }
    
    fprintf(Pos, "Red: %d, %d, %d\nYellow: %d, %d, %d\nWhite: %d, %d, %d", coordinates.redx, coordinates.redy, coordinates.redscore, coordinates.yellowx, coordinates.yellowy, coordinates.yellowscore, coordinates.whitex, coordinates.whitey, coordinates.whitescore);
    fclose(Pos);
    
    //Freeing up the memory and terminating the program
    free(pixels);
    free(ballcolor);
    free(ballscore);
    return 0;
}

// FUNCTIONS

//Converting from Hexadecimal to RGB function
void BallColor (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], unsigned int pixel[]) {
    for (int i=Lmin; i<Lmax; i++) {
        for (int j=Cmin; j<Cmax; j++) {
            ballcolor[i*C+j].red = (pixel[i*C+j] & 0x00FF0000) >> 16;
            ballcolor[i*C+j].green = (pixel[i*C+j] & 0x0000FF00) >> 8;
            ballcolor[i*C+j].blue = (pixel[i*C+j] & 0x000000FF);
        }
    }
}


//Calculating the scores of a 11 by 11 square for each pixel function
void BallScore (int C, int Lmin, int Lmax, int Cmin, int Cmax, color ballcolor[], pixelscore ballscore[], int whiterange[], int yellowrange[], int redrange[], int bluerange[]) {
    for (int i=Lmin; i<=Lmax-11; i++) {
        
        //Initiating each pixelscore at 0
        for (int k=Cmin; k<Cmax; k++) {
            ballscore[i*C+k].white = 0;
            ballscore[i*C+k].yellow = 0;
            ballscore[i*C+k].red = 0;
        }
        
        
        for (int j=Cmin; j<=Cmax-11; j++) {
            
            //While loop to skip the 11 by 11 square if the middle pixel is blue and going to the next pixel in order to optimize the algorithm
            while(ballcolor[(i+5)*C+j+5].red>=bluerange[0] && ballcolor[(i+5)*C+j+5].red<=bluerange[1] && ballcolor[(i+5)*C+j+5].green>=bluerange[2] && ballcolor[(i+5)*C+j+5].green<=bluerange[3] && ballcolor[(i+5)*C+j+5].blue>=bluerange[4] && ballcolor[(i+5)*C+j+5].blue<=bluerange[5]){
                j++;
            }
            
            //Loop calculating the scores of an 11 by 11 square (the reference pixel is in the upper left corner)
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

//Determining the coordinates function
struct coord BallCoord (int C, int Lmin, int Lmax, int Cmin, int Cmax, pixelscore ballscore[]) {
    
    //Initiating the coordinates at 0
    struct coord coordinates = {0, 0, 0, 0, 0, 0, 0, 0, 0} ;
    
    //Checking the max score and assigning the correct coordinates (j being the X value and i being the Y value)
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
