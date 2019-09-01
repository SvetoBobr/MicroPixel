// t45	attiny45	38400 prog
// board	MMCU		programm_after_make
//38400
//
#define CPU_TYPE	T45
#define F_CPU 8000000
#define	PROP_TYPE	MICROPIXEL	// more info in "opt-api.c"

#define FRAME_DELAY 1.5
#define MAX_LEVEL	255
#define HALF_LEVEL	60
#define PACK_SIZE	18

#define LED_PORT	PORTB
#define BOARD GDCV	//use GDCV for actual 30-60 l/m led strip 
//#define BOARD GCDV	//old 144 l/m 

#include "../../boards.h"

#include "apa102-driver-2.c"

#include <avr/io.h>

#include <util/delay.h>

#include "palette_7__.c"

#include <avr/eeprom.h>

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

//modes
#define MODE_NUM	11
#define S_NUM	13	// color schemes

unsigned char mode;
unsigned char s, ss;
unsigned char power;

EEMEM unsigned char	e_mode;
EEMEM unsigned char	e_serie;
EEMEM unsigned char	e_s_serie;

#define INC_DELAY	10
#define S_DELAY		100
#define P_DELAY		500

#define PRESSED			1
#define NOT_PRESSED		0

inline unsigned char process_button( unsigned int hold, unsigned int state);
inline unsigned char check_button();

#define LED_NUM	PACK_SIZE

// somy service vars
//rgb_pointer pack[PACK_SIZE];
//rgb_pointer scheme[PACK_SIZE];
unsigned char r[PACK_SIZE];
unsigned char g[PACK_SIZE];
unsigned char b[PACK_SIZE];
unsigned char mask[PACK_SIZE+1];

	rgb_pointer *pal;
	
unsigned char bbb=0;


void mode_1();
void mode_2();				
inline void mode_3();
inline void mode_4();
inline void mode_5();
inline void mode_6();
inline void mode_7();			
inline void mode_8();
inline void mode_9();			
inline void mode_10();					
inline void demo();	
inline void binary();

inline unsigned char const_light( unsigned char sch,  unsigned char delay );

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
			case 8:
				mode_8();
				break;;					
		}
		switch (sss){
			case 9:
				mode_10();
				break;;							
			case 10:
				binary();
				break;;
			case 11:
				demo();
				break;;
		}
}

int main(){
	
	mode = eeprom_read_byte(&e_mode);//Чтение
	s = eeprom_read_byte(&e_serie);//Чтение
	ss = eeprom_read_byte(&e_s_serie);//Чтение

	
	if (mode>MODE_NUM){
		mode=1;
	}
	
	if (s>S_NUM){
		s=1;
	}
	
	if (ss>1){
		ss=0;
	}
	
	power=1;

	init_io();
	
	/////////
	
	//mode=1;
	//s=10;
	/////////
	mr=hr;
	mg=hg;
	mb=hb;		
	for(;;){
		bbb=0;
		
		make_serie(mode);
		
		if ( ss==1 ){
			if ( ++s > 8 ){
				s=1;
			} 	
		}
		
		 
	}
	
	return 0;
}

void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  ){
	unsigned char i;
	for (i=0; i<n; i++){
		pack[i]= pal[0];
		if ( (i<8) && ( (mask&(1<<i))==(1<<i) ) ) pack[i]=color[i];
	}	
}

void mode_1(){	// const
	//unsigned char i;
	fill_mask();
	const_light(s, 10 );
}

void mode_2(){	// strob
	//unsigned char i;
	mode_1();

	//flush_mask();
	const_light(0, 10 );
}

void mode_3(){	// gears
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<=9 ) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 10 );
	
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<=9 ) mask[i]=0; else mask[i]=1;
	}
	const_light(s, 10 );
}

void mode_4(){	// not really flower
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i==1 || i==LED_NUM-a || i==1 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 1 );
	if (++a>LED_NUM) a=0;
}

void mode_5(){	// flower
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<=a || i==0 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 1 );
	if (++a>LED_NUM) a=0;
}

void mode_6(){	// chess
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( ((i+a) & 2)>0 ) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 1 );
	a++; a++;
	if (a>2) a=0;
}

void mode_7(){	// romb
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( ((i>a) && (i<(LED_NUM-a+1))) || (i==1) || (i==18) ) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 1 );
	if (++a>9-1) a=0;
}

/*
void mode_8(){	// anti romb
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<a || i>(LED_NUM-a) ) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 1 );
	if (++a>9) a=0;
}
*/

void mode_8(){
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( (((i+a) & 2)>0) || (i==1) || (i==18) ) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 1 );
	a++;
	if (a>LED_NUM) a=0;
}

void vPause(unsigned char l){
	flush_mask(); mask[1]=mask[18]=1;
	const_light(s, l);
}

void vV(){
	flush_mask(); mask[1]=mask[3]=mask[4]=mask[5]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[6]=mask[7]=mask[8]=mask[9]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[10]=mask[11]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[11]=mask[12]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[14]=mask[15]=mask[16]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[13]=mask[14]=mask[15]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[12]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[11]=mask[12]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[10]=mask[11]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[8]=mask[9]=mask[10]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[3]=mask[4]=mask[5]=mask[6]=mask[7]=mask[8]=mask[18]=1;
	const_light(s,1);
}

void vO(){
	fill_mask(); mask[2]=mask[3]=mask[17]=mask[16]=0;
	const_light(s,1);
	fill_mask(); mask[2]=mask[4]=mask[17]=mask[15]=0;
	const_light(s,1);
	flush_mask(); mask[1]=mask[3]=mask[16]=mask[18]=1;
	const_light(s,4);
	fill_mask(); mask[2]=mask[4]=mask[17]=mask[15]=0;
	const_light(s,1);
	fill_mask(); mask[2]=mask[3]=mask[17]=mask[16]=0;
	const_light(s,1);
}

void vL(){
	fill_mask(); mask[2]=mask[17]=0;
	const_light(s,1);
	flush_mask(); mask[1]=mask[16]=mask[18]=1;
	const_light(s,6);
}

void vK(){
	fill_mask(); mask[2]=mask[17]=0;
	const_light(s,1);
	flush_mask(); mask[1]=mask[8]=mask[9]=mask[10]=mask[11]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[7]=mask[8]=mask[11]=mask[12]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[6]=mask[12]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[5]=mask[6]=mask[12]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[4]=mask[5]=mask[13]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[4]=mask[13]=mask[14]=mask[18]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[3]=mask[4]=mask[14]=mask[15]=mask[16]=mask[18]=1;
	const_light(s,1);
}

void mode_9(){	// smth personal (optional?)
	vV(); vPause(1); vO(); vPause(1); vL(); vPause(1); vK(); vPause(1); vO(); vPause(1); vV(); vPause(5);
}

void _S(){
	flush_mask(); mask[3]=mask[4]=mask[5]=mask[6]=mask[16]=1;
	const_light(s, 1);
	flush_mask(); mask[2]=mask[7]=mask[17]=1;
	const_light(s, 1);
	flush_mask(); mask[1]=mask[8]=mask[18];
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[18];
	const_light(s,3);
	flush_mask(); mask[1]=mask[10]=mask[18];
	const_light(s,1);
	flush_mask(); mask[1]=mask[11]=mask[18];
	const_light(s,1);
	flush_mask(); mask[1]=mask[12]=mask[18];
	const_light(s,1);
	flush_mask(); mask[3]=mask[13]=mask[14]=mask[15]=mask[16];
	const_light(s,1);
	flush_mask();
	const_light(s, 4);
}

void _V(){
	flush_mask(); mask[1]=mask[2]=mask[3]=mask[4]=1;
	const_light(s,1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=1;
	const_light(s,1);
	flush_mask(); mask[9]=mask[10]=mask[11]=mask[12]=1;
	const_light(s,1);
	flush_mask(); mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(s,1);
	
	flush_mask(); mask[17]=mask[18]=1;
	const_light(s,1);
	
	flush_mask(); mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(s,1);
	flush_mask(); mask[9]=mask[10]=mask[11]=mask[12]=1;
	const_light(s,1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[2]=mask[3]=mask[4]=1;
	const_light(s,1);
		flush_mask();
	const_light(s, 4);
}

void _E(){
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=mask[8]=mask[18]=1;
	const_light(s,15);
		flush_mask();
	const_light(s, 4);
}

void _T(){
	flush_mask(); mask[1]=1;
	const_light(s,6);
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=1;
	const_light(s,6);
		flush_mask();
	const_light(s, 4);
}

void _O(){
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=mask[9]=mask[10]=mask[11]=mask[12]=mask[13]=mask[14]=1;
	const_light(s, 1);	
	flush_mask(); mask[3]=mask[4]=mask[15]=mask[16]=1;
	const_light(s, 1);
	flush_mask(); mask[2]=mask[17]=1;
	const_light(s,1);
	flush_mask(); mask[1]=mask[18]=1;
	const_light(s,3);
	flush_mask(); mask[2]=mask[17]=1;
	const_light(s,1);
	flush_mask(); mask[3]=mask[4]=mask[15]=mask[16]=1;
	const_light(s, 1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=mask[9]=mask[10]=mask[11]=mask[12]=mask[13]=mask[14]=1;
	const_light(s, 1);	
	flush_mask(); 
	const_light(s, 4);
}

void _B(){
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(s,4);
	flush_mask(); mask[2]=mask[8]=mask[10]=mask[17]=1;
	const_light(s,2);
	fill_mask(); mask[1]=mask[2]=mask[8]=mask[9]=mask[10]=mask[17]=mask[18]=0;
	const_light(s,1);
	
	flush_mask(); 
	const_light(s, 4);
}

void _R(){
	fill_mask();
	const_light(s,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(s,3);
	flush_mask(); mask[2]=mask[8]=mask[10]=mask[11]=1;
	const_light(s,1);
	flush_mask(); mask[2]=mask[8]=mask[12]=mask[13]=1;
	const_light(s,1);
	flush_mask(); mask[3]=mask[4]=mask[5]=mask[6]=mask[7]=1;
	mask[14]=mask[15]=mask[16]=mask[17]=mask[18]=1;
	const_light(s,1);
	
	flush_mask(); 
	const_light(s, 4);
}

void mode_10(){	//	svetobobr
	_S(); _V(); _E(); _T(); _O(); _B(); _O(); _B(); _R();
	flush_mask();
	const_light(s, 30 );
}

		
void binary(){
	unsigned static a;
	unsigned char i;
	for ( i=0; i<LED_NUM; i++ ) {
		if ( (i & a)>0 ) mask[i]=1; else mask[i]=0;
	}
	const_light(s, 10 );
	if (++a>LED_NUM) a=0;
}

unsigned char check_button(){
	
	static unsigned int hold=0;
	static unsigned char button_state=NOT_PRESSED;
	static unsigned char last_button_state=NOT_PRESSED;
	
	unsigned char	st=BUTTON_PIN;
	unsigned char res=0;
	
	button_state=NOT_PRESSED;
	
	if ( ( (st &  (1<<BUTTON_1))  == (0<<BUTTON_1) ) ) {
		button_state = PRESSED;
	}
	
	if ( button_state == PRESSED ){
		hold++;
	}
	
	if ( last_button_state == button_state ){
		res = process_button( hold, button_state );
	}
	
	if ( button_state == NOT_PRESSED &&  last_button_state == NOT_PRESSED ){
		hold=0;
	}
	
	last_button_state=button_state;

	//res=button_state;
	return res;
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
			//	mask[j]=2;
			}
			//if ( check_button()==1 ) return 1;
		} else {
			switch (sch){
				case 8:
					for (j=0; j<6; j++){
						if (power==1){
							r[j]=150; r[j+6]=0; r[j+12]=255;
							g[j]=150; g[j+6]=0; g[j+12]=0;
							b[j]=150; b[j+6]=255; b[j+12]=0;
						} else {
							r[j]=50; r[j+6]=0; r[j+12]=100;
							g[j]=50; g[j+6]=0; g[j+12]=0;
							b[j]=50; b[j+6]=100; b[j+12]=0;
						}
					}
					break;
				case 9:
					for (j=0; j<18; j+=3){
						if (power==1){
							r[j]=255; r[j+1]=0; r[j+2]=0;
							g[j]=0; g[j+1]=0; g[j+2]=255;
							b[j]=0; b[j+1]=255; b[j+2]=0;
						} else {
							r[j]=100; r[j+1]=0; r[j+2]=0;
							g[j]=0; g[j+1]=0; g[j+2]=100;
							b[j]=0; b[j+1]=100; b[j+2]=0;
						}
					}
					break;
				case 10:	// GR rainbow
					for (j=0; j<18; j++){
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
				case 11:	// RB rainbow
					for (j=0; j<18; j++){
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
					for (j=0; j<18; j++){
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
					for (j=0; j<18; j++){
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

unsigned char process_button( unsigned int hold, unsigned int state){
	if ( hold > P_DELAY ){
		if ( state == NOT_PRESSED ){
			if (++power>1) power=0;
			
			if (power==1){
				 //pal=palette;
				 mr=fr;
				 mg=fg;
				 mb=fb;
			 } else {
				 //pal=h_palette;
				 mr=hr;
				 mg=hg;
				 mb=hb;			 
			 }
			//eeprom_write_byte(&e_power, power);	// processed in main
			return 1;
		}
	} else if ( hold > S_DELAY ){	// next serie
		if ( state == NOT_PRESSED ){
			if ( ++mode > MODE_NUM ) { 
				mode=1; 
			}
			
			eeprom_write_byte(&e_mode,   mode);//Запись

			return 1;
		}		
	}  else if ( hold > INC_DELAY ){	// next mode
		if ( state == NOT_PRESSED ){
			if (ss==1){
				ss=0;
				s=1;
			} else 	if ( ++s > S_NUM ){
				s=1;
				ss=1;
				
				//if (mode>=7) { 					ss=0;				}
			} 	
			
			eeprom_write_byte(&e_mode,   mode);//Запись
			eeprom_write_byte(&e_serie,   s);//Запись
			eeprom_write_byte(&e_s_serie,   ss);//Запись	
			
			return 1;
		}
		
	}
	
	return 0;
}


#define SP_L	2
#define	SB_L	1










void demo(){
	static unsigned char mmm=1;
	static unsigned char nnn=1;
	//s=1;
	
	make_serie(mmm);
	nnn++;
	
	if (nnn>10){
		s++;
		nnn=1;
	}
	
	if (s>S_NUM){
		mmm++;
		s=1;
	}
	
	if (mmm>=MODE_NUM){
		mmm=0;
	}
	
}
