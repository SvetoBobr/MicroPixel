// include somwhere after "apa102-driver.c"
// disigned foe micropixel series

//#include "apa102-driver.c"

#ifndef PALETTE_7

#define PALETTE_7

#ifndef MAX_LEVEL
	#define MAX_LEVEL	255
#endif

#ifndef HALF_LEVEL
	#define HALF_LEVEL	100
#endif

#define black 	0
#define red 	1
#define yellow 	2
#define green 	3
#define aqua 	4
#define blue 	5
#define violet	6
#define white	7
#define combo 	8

unsigned char mr[8]={0, MAX_LEVEL, MAX_LEVEL, 0,    0,   0,   MAX_LEVEL, MAX_LEVEL };
unsigned char mg[8]={0, 0, 	 MAX_LEVEL, MAX_LEVEL,  MAX_LEVEL, 0,   0,   MAX_LEVEL };
unsigned char mb[8]={0, 0, 	 0,   0,    MAX_LEVEL, MAX_LEVEL, MAX_LEVEL, MAX_LEVEL };

#endif
