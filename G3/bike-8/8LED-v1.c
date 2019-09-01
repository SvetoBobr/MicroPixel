// t45	attiny45	38400 prog
// board	MMCU		programm_after_make

// 8LED bike backlight


// ***************** HARDWARE SECTION ****************************************************
#define CPU_TYPE	T45
#define F_CPU 8000000
#define	PROP_TYPE	MICROPIXEL	// more info in "opt-api.c"

#define LED_PORT	PORTB
#define BOARD GCDV	//use GDCV for actual 30-60 l/m led strip 
#include "../../boards.h"


// ***************** BASIC GLOW SETTINGS & MODES *****************************************
#define FRAME_DELAY NO_DELAY	// as fast as MCU can
#define MAX_LEVEL	80
#define HALF_LEVEL	20			// brightness in economic mode

#define PACK_SIZE	8
#define LED_NUM	PACK_SIZE

// patterns and colors	
// totally changet between G2 and G3 - be careful
#define MODE_NUM	13	// color schemes number
#define S_NUM	7		// patterns number
#define MODE_GATE	6

#if MODE_GATE>MODE_NUM
	#undef MODE_GATE
	#define MODE_GATE	MODE_NUM
#endif

unsigned char mode;
unsigned char serie, ss;
unsigned char power;

// ***************** ADVANCED BEHAVIOR & MODULES *****************************************
// uncoment to enable fav 
//#define USE_FAV
// comment not to use
#define SOFTWARE_SLEEP

#define INC_DELAY	14
#define S_DELAY		100
//#define W_FAV_DELAY	3000
//#define T_FAV_DELAY	10000
//#define CLEAR_DELAY 18000
#define HALT_DELAY  1000
#define WAKE_THRESHOLD	100
#include "../apa102-driver-2.c"
#include "../palette_7__.c"
#include "../memory-api.c"
#include "../power-api.c"
#include "../button-api.c"
#include "../opt-api.c"


// =========================================================================================================
// =================== MAIN SECTION ========================================================================
// =========================================================================================================

// >>>>>>>>>>> service functions & vars >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
unsigned char r[PACK_SIZE];
unsigned char g[PACK_SIZE];
unsigned char b[PACK_SIZE];
unsigned char mask[PACK_SIZE+1];

unsigned char bbb=0;

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );

void fill_mask();
void flush_mask();

inline unsigned char const_light( unsigned char sch,  unsigned char delay );

// >>>>>>>>>>> modes  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
void  make_serie(unsigned char sss);
inline void mode_1();
inline void mode_2();				
inline void mode_3();
inline void mode_4();
inline void mode_5();
inline void mode_6();
inline void mode_7();			



// >>>>>>>>>> main part >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

int main(){
	read_data();
	check_all();
	
	//power=ACTIVE;
	stat=0;
	ss=0;
	
	init_io();
	

	cli();
	
	//_set_active();
	
	mr=hr;
	mg=hg;
	mb=hb;		
	for(;;){ 
		bbb=0;
		cli();
		
		if ( power==IDLE ){
				const_light(0, 1 );	// fade strip
			DDRB=0;
			PORTB=(1<<MODE_BUTTON);
			//go_sleep();
			set_sleep_mode(SLEEP_MODE_PWR_DOWN);
			sleep_enable();
			_interrupts_on();
			sleep_cpu();
			sleep_disable();
		} 	else if (stat==0) {
			make_serie(serie);
		}	else {
			process_signal(stat);
		} 
		
		if ( ss==1 ){
			if ( ++mode > MODE_GATE ){
				mode=1;
			} 	
		}
	}
	
	return 0;
}

void flush_mask(){
	unsigned char i;
	for ( i=0; i<=LED_NUM; i++ )	mask[i]=0;
}

void fill_mask(){
	unsigned char i;
	for ( i=0; i<=(LED_NUM); i++ )	mask[i]=1;
}

void make_serie(unsigned char sss){
	switch (sss){
			case 1:
				mode_1();
				break;;
			case 2:
				mode_2();
				break;;
			case 3:
				mode_3();
				break;;
			case 4:
				mode_4();
				break;;
		}
		
		switch (sss){
			case 5:
				mode_5();
				break;;
			case 6:
				mode_6();
				break;;
			case 7:
				mode_7();
				break;;	
		}
}

unsigned char  const_light( unsigned char sch,  unsigned char delay){
	static unsigned char rgb[3]={255,0,0};
	static unsigned char rgb2[3]={255,0,0};
	static unsigned char rgb3[3]={255,0,0};
	static unsigned char rgb4[3]={0,0,255};
	static unsigned char rgbs=0;
	//static unsigned char b1=0;
	unsigned char i, j;
			 
	if (bbb==1) return 1;
	
	for (i=0; i<delay; i++){
		if (sch<8){
			for (j=0; j<LED_NUM; j++){
				r[j]=mr[sch];
				g[j]=mg[sch];
				b[j]=mb[sch];
			}
		} else {
			switch (sch){
				case 8:
					for (j=0; j<LED_NUM; j++){
						if (power==1){
							if ( (j<2) || (j>(LED_NUM-3)) ) {
								r[j]=MAX_LEVEL; g[j]=MAX_LEVEL; b[j]=0;
							} else {
								r[j]=0; g[j]=MAX_LEVEL; b[j]=0;
							}

						} else {
							if ( (j<2) || (j>(LED_NUM-3)) ) {
								r[j]=HALF_LEVEL; g[j]=HALF_LEVEL; b[j]=0;
							} else {
								r[j]=0; g[j]=HALF_LEVEL; b[j]=0;
							}

						}
					}
					break;
				case 9:
					for (j=0; j<LED_NUM; j++){
						if (power==1){
							if ( (j<2) || (j>(LED_NUM-3)) ) {
								r[j]=MAX_LEVEL; g[j]=0; b[j]=0;
							} else {
								r[j]=0; g[j]=0; b[j]=MAX_LEVEL;
							}

						} else {
							if ( (j<2) || (j>(LED_NUM-3)) ) {
								r[j]=HALF_LEVEL; g[j]=0; b[j]=0;
							} else {
								r[j]=0; g[j]=0; b[j]=HALF_LEVEL;
							}

						}
					}
					break;
				case 10:	// GR rainbow
					for (j=0; j<LED_NUM; j++){
						if (power==1){
							r[j]=rgb2[0]; 
							g[j]=rgb2[1]; 
							b[j]=rgb2[2]; 
						} 
					}
					if (rgbs==0) {	// r>y>g
						rgb2[1]++;
						rgb2[0]--;
						if (rgb2[1]==255) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb2[1]--;
						rgb2[0]++;
						if (rgb2[0]==255) rgbs=0;
					} 
					break;
				}
				switch (sch){
				case 11:	// RB rainbow
					for (j=0; j<LED_NUM; j++){
						if (power==1){
							r[j]=rgb3[0]; 
							g[j]=rgb3[1]; 
							b[j]=rgb3[2]; 
						} 
					}
					if (rgbs==0) {	// r>y>g
						rgb3[2]++;
						rgb3[0]--;
						if (rgb3[2]==255) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb3[2]--;
						rgb3[0]++;
						if (rgb3[0]==255) rgbs=0;
					} 
					break;
				case 12:	// GB rainbow
					for (j=0; j<LED_NUM; j++){
						if (power==1){
							r[j]=rgb4[0]; 
							g[j]=rgb4[1]; 
							b[j]=rgb4[2]; 
						} 
					}
					if (rgbs==0) {	// r>y>g
						rgb4[1]++;
						rgb4[2]--;
						if (rgb4[1]==255) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb4[1]--;
						rgb4[2]++;
						if (rgb4[2]==255) rgbs=0;
					} 
					break;
				case 13:	// full rainbow
					for (j=0; j<LED_NUM; j++){
						if (power==1){
							r[j]=rgb[0]; 
							g[j]=rgb[1]; 
							b[j]=rgb[2]; 
						} 
					}
					
					if (rgbs==0) {	// r>y>g
						rgb[1]++;
						rgb[0]--;
						if (rgb[1]==255) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb[2]++;
						rgb[1]--;
						if (rgb[2]==255) rgbs++;
					} else if (rgbs==2) {	// b>v>r
						rgb[2]--;
						rgb[0]++;
						if (rgb[2]==0) rgbs=0;
					} else rgbs=0;
					break;
			}
		}		
			
		if ( check_button()==1 ) {
			bbb=1;
			return 1;	
		}
		
		sendRawRGBpack(LED_NUM, r, g, b, mask);	
	}
	
	return 0;
}

// >>>>>>>>>>>>>> modes section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#if LED_NUM==8
	#define M_DELAY	140
	#define M_DELAY2	60
	#define M_DELAY3	15
#endif

#if LED_NUM==15
	#define M_DELAY	80
	#define M_DELAY2	35
	#define M_DELAY3	8
	#warning 15 leds
#endif

void mode_1(){	// const
	//unsigned char i;
	fill_mask();
	const_light(mode, M_DELAY );
}

void mode_2(){	// strob
	//unsigned char i;
	mode_1();

	//flush_mask();
	const_light(0, M_DELAY );
}

void mode_3(){	// blinking corners
	fill_mask();
	const_light(mode, M_DELAY );
	
	mask[1]=mask[2]=mask[LED_NUM-1]=mask[LED_NUM]=0;
	const_light(mode, M_DELAY );
}

void mode_4(){	// more complicated blinking 
	unsigned char i;
	
	for (i=0; i<4; i++){	// corners ON
		fill_mask();
		mask[1]=mask[2]=mask[LED_NUM-1]=mask[LED_NUM]=1;
		const_light(mode, M_DELAY3 );
		flush_mask();
		mask[1]=mask[2]=mask[LED_NUM-1]=mask[LED_NUM]=1;
		const_light(mode, M_DELAY3 );
	}
	for (i=0; i<4; i++){ // corners OFF
		fill_mask();
		mask[1]=mask[2]=mask[LED_NUM-1]=mask[LED_NUM]=0;
		const_light(mode, M_DELAY3 );
		flush_mask();
		mask[1]=mask[2]=mask[LED_NUM-1]=mask[LED_NUM]=0;
		const_light(mode, M_DELAY3 );
	}	
}

void mode_5(){	// not really flower
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i==1 || i==LED_NUM-a || i==a+1 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, M_DELAY2 );
	if (++a>LED_NUM) a=0;
}

void mode_6(){	// left-right
	unsigned static dir=0;
	unsigned static a=1;
	unsigned char i;

	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i==a || i==1 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}

	const_light(mode, M_DELAY2 );
	
	if (dir==0){
		if (++a==LED_NUM) { 
			dir++;
		}
	} else {
		if (--a==1) { 
			dir=0;
		}	
	}
}

void mode_7(){	// romb
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( ((i>a) && (i<(LED_NUM-a+1))) || (i==1) || (i==LED_NUM) ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, M_DELAY2 );
	if (++a>LED_NUM/2) a=0;
}


