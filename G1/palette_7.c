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

#define black 	&OOO
#define red 	&ROO
#define yellow 	&RGO
#define green 	&OGO
#define aqua 	&OGB
#define blue 	&OOB
#define violet	&ROB
#define white	&WWW
#define combo 	&COM

struct RGB OOO = {0,0,0};

struct RGB ROO = {MAX_LEVEL,0,0};
struct RGB OGO = {0,MAX_LEVEL,0};
struct RGB OOB = {0,0,MAX_LEVEL};

struct RGB RGO = {MAX_LEVEL,MAX_LEVEL,0};
struct RGB OGB = {0,MAX_LEVEL,MAX_LEVEL};
struct RGB ROB = {MAX_LEVEL,0,MAX_LEVEL};

struct RGB WWW = {MAX_LEVEL,MAX_LEVEL,MAX_LEVEL};
struct RGB COM = {0,0,0};

rgb_pointer palette[8]={black, red, yellow, green, aqua, blue, violet, white};


#define h_red 		&ROOH
#define h_yellow 	&RGOH
#define h_green 	&OGOH
#define h_aqua 		&OGBH
#define h_blue 		&OOBH
#define h_violet	&ROBH
#define h_white		&WWWH

struct RGB ROOH = {HALF_LEVEL,0,0};
struct RGB OGOH = {0,HALF_LEVEL,0};
struct RGB OOBH = {0,0,MAX_LEVEL};

struct RGB RGOH = {HALF_LEVEL,HALF_LEVEL,0};
struct RGB OGBH = {0,HALF_LEVEL,HALF_LEVEL};
struct RGB ROBH = {HALF_LEVEL,0,HALF_LEVEL};

struct RGB WWWH = {HALF_LEVEL,HALF_LEVEL,HALF_LEVEL};

rgb_pointer h_palette[8]={black, h_red, h_yellow, h_green, h_aqua, h_blue, h_violet, h_white};

#endif
