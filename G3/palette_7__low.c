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
#define orange	2
#define yellow 	3
#define green 	4
#define aqua 	5
#define blue 	6
#define violet	7
#define white	8
//#define combo 	8

unsigned char mr[9]={0, MAX_LEVEL, MAX_LEVEL,	MAX_LEVEL, 0,    0,   0,   MAX_LEVEL, MAX_LEVEL };
unsigned char mg[9]={0, 0, 	 	   HALF_LEVEL,	MAX_LEVEL, MAX_LEVEL,  MAX_LEVEL, 0,   0,   MAX_LEVEL };
unsigned char mb[9]={0, 0, 	 	   0,			0,   0,    MAX_LEVEL, MAX_LEVEL, MAX_LEVEL, MAX_LEVEL };

#endif
