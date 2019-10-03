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

#define FRAME_DELAY 1	// there are some problems wth this constant
#define MAX_LEVEL	255
#define HALF_LEVEL	60
#define PACK_SIZE	4

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

#include "./micropixel_4led_modes.h"



unsigned char mode;
unsigned char serie;//, ss;
unsigned char power;


// ***************** ADVANCED BEHAVIOR & MODULES *****************************************
// uncoment to enable fav 
#define USE_FAV
#define FAV_MAX	15
// comment not to use
#define SOFTWARE_SLEEP
#define ECONOM_ENABLED


// #define RESET_MODE_ON_SERIE	// uncomment to start each serie fron 1st mode

#define INC_DELAY	150
#define S_DELAY		700
#define ECONOM_DELAY	1500
#define HALT_DELAY  	3000
#define W_FAV_DELAY		6000
#define T_FAV_DELAY		12000
#define CLEAR_DELAY 	18000

#define WAKE_THRESHOLD	20

#ifdef ECONOM_ENABLED
	unsigned char econom=0;
//	unsigned char level;
#endif



//#include "../fav-api.h"

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
void flush();

inline unsigned char const_light( unsigned char sch,  unsigned char delay );

// >>>>>>>>>>> modes  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
void  make_serie(unsigned char sss);

#include "./micropixel_4led_modes.c"

// >>>>>>>>>> main part >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

int main(){
	read_data();
	check_all();
	
	power=ACTIVE;
	stat=0;
	//ss=0;
	
	init_io();
	
	econom=0;

	cli();
	
	//serie=9;
/*
	mr=fr;
	mg=fg;
	mb=fb;		
	*/
	unsigned char res_mode=0;
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
			if (fav_on==0){
				make_serie(serie);
			} else {
				if (counter>0){
					res_mode=mode;
					mode=modes[pointer];
					make_serie(series[pointer]);
					mode=res_mode;
				} else {
					process_signal(SIGNAL_UNDEFINED_STATE);
				}
			}
		}	else {
			process_signal(stat);
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

static unsigned char rgb[3];
static unsigned char rgb2[3];
static unsigned char rgb3[3];
static unsigned char rgb4[3];

	
void flush(){
	unsigned char i;
	for (i=0; i<LED_NUM; i++){
		r[i]=g[i]=b[i]=0;
	}
}

void l_shift(unsigned char arr[], unsigned char l){
	unsigned char i;
	unsigned char tmp=arr[0];
	for (i=1; i<l; i++){
		arr[i-1]=arr[i];
	}
	arr[l-1]=tmp;
}

void r_shift(unsigned char arr[], unsigned char l){
	unsigned char i;
	unsigned char tmp=arr[l-1];
	for (i=l-1; i>0; i--){
		arr[i]=arr[i-1];
	}
	arr[0]=tmp;
}


unsigned char wave_1[PACK_SIZE]={255,140,55,5};
unsigned char wave_2[PACK_SIZE]={255,140,55,5};
unsigned char wave_3[PACK_SIZE]={50,255,50,0};

unsigned char  const_light( unsigned char sch,  unsigned char delay){
	static unsigned char rgbs=0;
	static unsigned char tmpsch=1;
	static unsigned char counter=0;
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
					flush();
					r[1]=r[3]=g[2]=g[0]=MAX_LEVEL;
					break;
				case 9:
					flush();
					b[1]=b[3]=g[2]=g[0]=MAX_LEVEL;
					break;
				case 10:	// russian flag
					flush();
					r[1]=r[3]=b[2]=b[0]=MAX_LEVEL;
					break;
			}		
					
			switch (sch){	case 11:	// green-red
					flush();
					r[1]=r[2]=g[3]=g[0]=MAX_LEVEL;
					break;
				case 12:	// blue-red
					flush();
					b[1]=b[2]=g[3]=g[0]=MAX_LEVEL;
					break;					
				case 13:	// b-r-g
					flush();
					r[1]=r[2]=b[3]=b[0]=MAX_LEVEL;
					break;
			}
			
			switch (sch){		
				case 14:	// GR rainbow
					for (j=0; j<LED_NUM; j++){
						r[j]=rgb2[0]; 
						g[j]=rgb2[1]; 
						b[j]=rgb2[2]; 
					}
					if (rgbs==0) {	// r>y>g
						rgb2[1]++;
						rgb2[0]--;
						if (rgb2[1]==MAX_LEVEL) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb2[1]--;
						rgb2[0]++;
						if (rgb2[0]==MAX_LEVEL) rgbs=0;
					} 
					break;
				}
				switch (sch){
				case 15:	// RB rainbow
					for (j=0; j<LED_NUM; j++){

							r[j]=rgb3[0]; 
							g[j]=rgb3[1]; 
							b[j]=rgb3[2]; 
						
					}
					if (rgbs==0) {	// r>y>g
						rgb3[2]++;
						rgb3[0]--;
						if (rgb3[2]==MAX_LEVEL) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb3[2]--;
						rgb3[0]++;
						if (rgb3[0]==MAX_LEVEL) rgbs=0;
					} 
					break;
				case 16:	// GB rainbow
					for (j=0; j<LED_NUM; j++){
							r[j]=rgb4[0]; 
							g[j]=rgb4[1]; 
							b[j]=rgb4[2]; 
					}
					if (rgbs==0) {	// r>y>g
						rgb4[1]++;
						rgb4[2]--;
						if (rgb4[1]==MAX_LEVEL) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb4[1]--;
						rgb4[2]++;
						if (rgb4[2]==MAX_LEVEL) rgbs=0;
					} 
					break;
				case 17:	// full rainbow
					for (j=0; j<LED_NUM; j++){
							r[j]=rgb[0]; 
							g[j]=rgb[1]; 
							b[j]=rgb[2]; 
					}
					
					if (rgbs==0) {	// r>y>g
						rgb[1]++;
						rgb[0]--;
						if (rgb[1]==MAX_LEVEL) rgbs++;
					} else if (rgbs==1) {	// g>aq>b
						rgb[2]++;
						rgb[1]--;
						if (rgb[2]==MAX_LEVEL) rgbs++;
					} else if (rgbs==2) {	// b>v>r
						rgb[2]--;
						rgb[0]++;
						if (rgb[2]==0) rgbs=0;
					} else rgbs=0;
					break;
				case 18: 
					for (j=0; j<LED_NUM; j++){
						r[j]=mr[tmpsch];
						g[j]=mg[tmpsch];
						b[j]=mb[tmpsch];
					}
					if (++tmpsch>8) tmpsch=1;
			}
						switch (sch){
				case 19:
					if (++counter>=60){
						counter=0;
						l_shift(wave_1, LED_NUM);
						r_shift(wave_2, LED_NUM);
					}
					for (j=0; j<LED_NUM; j++){
						r[j]=wave_1[j];
						g[j]=wave_2[j];
						b[j]=0;
					} 
					break;
				case 20:
					if (++counter>=60){
						counter=0;
						l_shift(wave_1, LED_NUM);
						r_shift(wave_2, LED_NUM);
					}
					for (j=0; j<LED_NUM; j++){
						r[j]=wave_1[j];
						g[j]=0;
						b[j]=wave_2[j];
					}
					break;
				case 21:
					if (++counter>=60){
						counter=0;
						l_shift(wave_1, LED_NUM);
						r_shift(wave_2, LED_NUM);
					}
					
					for (j=0; j<LED_NUM; j++){
						r[j]=0;
						g[j]=wave_1[j];
						b[j]=wave_2[j];
					}
					break;
				case 22:
					if (++counter>=60){
						counter=0;
						l_shift(wave_1, LED_NUM);
						r_shift(wave_2, LED_NUM);
					}
					
					for (j=0; j<LED_NUM; j++){
						r[j]=wave_3[j];
						g[j]=wave_1[j];
						b[j]=wave_2[j];
					}
					break;
			}
			
		}		
			
		if ( check_button()==1 ) {
			bbb=1;
			return 1;	
		}
		
		for (j=0; j<=LED_NUM; j++)
			if (econom==1){
				r[j]=r[j]>>2;
				g[j]=g[j]>>2;
				b[j]=b[j]>>2;
			} else if (econom==2){
				r[j]=r[j]>>4;
				g[j]=g[j]>>4;
				b[j]=b[j]>>4;	
			} else if (econom==3){
				r[j]=r[j]>>6;
				g[j]=g[j]>>6;
				b[j]=b[j]>>6;	
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
