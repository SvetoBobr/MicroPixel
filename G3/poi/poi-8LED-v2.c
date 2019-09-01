// t45	attiny45	38400 prog
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

#define FRAME_DELAY 1			// as fast as MCU can
#define MAX_LEVEL	255
#define HALF_LEVEL	60			// brightness in economic mode

#define PACK_SIZE	8

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
#define MODE_NUM	14
#define S_NUM	11

#define DEMO_S_NUM	10

#define LED_NUM	8

unsigned char mode;
unsigned char serie, ss;
unsigned char power;


// ***************** ADVANCED BEHAVIOR & MODULES *****************************************
// uncoment to enable fav 
//#define USE_FAV
// comment not to use
#define SOFTWARE_SLEEP
#define ECONOM_ENABLED

#define INC_DELAY	14
#define S_DELAY		100
#define ECONOM_DELAY	700

//#define W_FAV_DELAY	3000
//#define T_FAV_DELAY	10000
//#define CLEAR_DELAY 18000
#define HALT_DELAY  1500
#define WAKE_THRESHOLD	20

#ifdef ECONOM_ENABLED
	unsigned char econom=0;
	unsigned char level;
#endif

void set_level(unsigned char );

#include "../apa102-driver-2.c"
#include "../palette_7__low.c"
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

	rgb_pointer *pal;
	
unsigned char bbb=0;

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

void fill_mask();
void flush_mask();

inline unsigned char const_light( unsigned char sch,  unsigned char delay );

// >>>>>>>>>>> modes  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
void  make_serie(unsigned char sss);

#include "./micropixel_8led_modes.c"


// >>>>>>>>>> main part >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

int main(){
	read_data();
	check_all();
	
	power=ACTIVE;
	stat=0;
	ss=0;
	
	init_io();
	

	cli();
	
	if (econom==1) {
		set_level(HALF_LEVEL);
	} else {
		set_level(MAX_LEVEL);
	}
	//_set_active();
	
	mr=fr;
	mg=fg;
	mb=fb;		
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
		/*
		 if (econom==1){
			 pal=h_palette;
		 } else {
			 pal=palette;
		 }*/
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

static unsigned char rgb[3];
static unsigned char rgb2[3];
static unsigned char rgb3[3];
static unsigned char rgb4[3];

	
void set_level(unsigned char l){
	level=l;
	rgb[0]=rgb2[0]=rgb3[0]=rgb4[2]=level;
	rgb[1]=rgb2[1]=rgb3[1]=rgb[2]=rgb2[2]=rgb3[2]=rgb4[0]=rgb4[1]=0;

}

unsigned char  const_light( unsigned char sch,  unsigned char delay){

	
	
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
						if ( (j<2) || (j>(LED_NUM-3)) ) {
							r[j]=level; g[j]=level; b[j]=0;
						} else {
							r[j]=0; g[j]=level; b[j]=0;
						}
					}
					break;
				case 9:
					for (j=0; j<LED_NUM; j++){

							if ( (j<2) || (j>(LED_NUM-3)) ) {
								r[j]=level; g[j]=0; b[j]=0;
							} else {
								r[j]=0; g[j]=0; b[j]=level;
							}

						
					}
					break;
				case 10:	// GR rainbow
					for (j=0; j<LED_NUM; j++){

							r[j]=rgb2[0]; 
							g[j]=rgb2[1]; 
							b[j]=rgb2[2]; 
						
					}
					if (rgbs==0) {	// r>y>g
						rgb2[1]++;
						rgb2[0]--;
						if (rgb2[1]==level) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb2[1]--;
						rgb2[0]++;
						if (rgb2[0]==level) rgbs=0;
					} 
					break;
				}
				switch (sch){
				case 11:	// RB rainbow
					for (j=0; j<LED_NUM; j++){

							r[j]=rgb3[0]; 
							g[j]=rgb3[1]; 
							b[j]=rgb3[2]; 
						
					}
					if (rgbs==0) {	// r>y>g
						rgb3[2]++;
						rgb3[0]--;
						if (rgb3[2]==level) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb3[2]--;
						rgb3[0]++;
						if (rgb3[0]==level) rgbs=0;
					} 
					break;
				case 12:	// GB rainbow
					for (j=0; j<LED_NUM; j++){
							r[j]=rgb4[0]; 
							g[j]=rgb4[1]; 
							b[j]=rgb4[2]; 
					}
					if (rgbs==0) {	// r>y>g
						rgb4[1]++;
						rgb4[2]--;
						if (rgb4[1]==level) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb4[1]--;
						rgb4[2]++;
						if (rgb4[2]==level) rgbs=0;
					} 
					break;
				case 13:	// full rainbow
					for (j=0; j<LED_NUM; j++){

							r[j]=rgb[0]; 
							g[j]=rgb[1]; 
							b[j]=rgb[2]; 

					}
					
					if (rgbs==0) {	// r>y>g
						rgb[1]++;
						rgb[0]--;
						if (rgb[1]==level) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb[2]++;
						rgb[1]--;
						if (rgb[2]==level) rgbs++;
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
	#define M_DELAY4	1
#endif

#if LED_NUM==15
	#define M_DELAY	80
	#define M_DELAY2	35
	#define M_DELAY3	8
	#warning 15 leds
#endif
