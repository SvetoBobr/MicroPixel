// t85	attiny85	38400 prog
// board	MMCU		programm_after_make

// 8LED bike backlight


// ***************** HARDWARE SECTION ****************************************************
#define CPU_TYPE	T45
#define F_CPU 8000000
#define	PROP_TYPE	MICROPIXEL	// more info in "opt-api.c"

#define LED_PORT	PORTB
#define BOARD GDCV	//use GDCV for actual 30-60 l/m led strip 
#include "../../boards.h"

#define WLED_PIN	3
// ***************** BASIC GLOW SETTINGS & MODES *****************************************

#define FRAME_DELAY 0	// there are some problems wth this constant
#define MAX_LEVEL	255
#define HALF_LEVEL	60
#define PACK_SIZE	50

/*
#define FRAME_DELAY NO_DELAY	// as fast as MCU can
#define MAX_LEVEL	60
#define HALF_LEVEL	20			// brightness in economic mode

#define PACK_SIZE	8
#define LED_NUM	PACK_SIZE
*/

// patterns and colors	
// totally changed between G2 and G3 - be careful
#define MODE_GATE	6

#if MODE_GATE>MODE_NUM
	#undef MODE_GATE
	#define MODE_GATE	MODE_NUM
#endif

//modes


unsigned char mode;
unsigned char serie;//, ss;
unsigned char power;


// ***************** ADVANCED BEHAVIOR & MODULES *****************************************
// uncoment to enable fav 
//#define USE_FAV
#define FAV_MAX	15
// comment not to use
//#define SOFTWARE_SLEEP
//#define ECONOM_ENABLED



#include "../apa102-driver-2.c"
//#include "../palette_7__low.c"
//#include "../memory-api.c"
//#include "../power-api.c"
//#include "../button-api.c"
//#include "../opt-api.c"


// =========================================================================================================
// =================== MAIN SECTION ========================================================================
// =========================================================================================================

// >>>>>>>>>>> service functions & vars >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
unsigned char r[PACK_SIZE];
unsigned char g[PACK_SIZE];
unsigned char b[PACK_SIZE];
unsigned char mask[PACK_SIZE+1];



//inline unsigned char const_light( unsigned char sch,  unsigned char delay );

// >>>>>>>>>>> modes  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// >>>>>>>>>> main part >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

int main(){
//	read_data();
//	check_all();
	
//	power=ACTIVE;
//	stat=0;
	//ss=0;
	
	init_io();

	unsigned char j=0;
	for(;;){ 
		
		for (j=0; j<PACK_SIZE; j++){
			r[j]=10;
			g[j]=0;
			b[j]=0;
			mask[j]=1;
		}
		for (j=3; j<PACK_SIZE; j+=4){
			b[j]=10;
		}
		mask[50]=1;
		sendRawRGBpack(50, r, g, b, mask);		
	}
	
	return 0;
}


// >>>>>>>>>>>>>> modes section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#if LED_NUM==8
	#define M_DELAY	140
	#define M_DELAY2	60
	#define M_DELAY3	15
	#define M_DELAY4	1
#endif

#if LED_NUM==15
	#define M_DELAY	80
	#define M_DELAY2	35
	#define M_DELAY3	8
	#warning 15 leds
#endif
