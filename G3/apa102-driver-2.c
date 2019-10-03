// G3 apa102 led strip driver for attiny45 or pin-to-pin compatible MCU

#ifndef T45_APA102DRIVER_V2

#define T45_APA102DRIVER_V2

#include <avr/io.h>
#include <util/delay.h>

/*
#define DATA0	0
#define DATA1	1<<1
#define CLOCK0	0
#define CLOCK1	1<<2
*/
#ifndef LED_PORT
	#warning "LED_PORT NOT DEFINED - using PB default"
	#define LED_PORT PORTB
#endif


#define DATA0	0
#define DATA1	1<<DATA_PIN
#define CLOCK0	0
#define CLOCK1	1<<CLK_PIN

#define NO_DELAY	0

#ifndef FRAME_DELAY
	#warning "FRAME_DELAY NOT DEFINED - using 100"
	#define FRAME_DELAY	100
#endif

#ifndef START_BYTE
	#define START_BYTE	255

#endif

struct RGB{
	unsigned char R;
	unsigned char G;
	unsigned char B;
};

typedef  struct RGB* rgb_pointer;

#ifndef WLED_PIN
	#define MASK (1<<MODE_BUTTON) | (1<<GND_PIN)  	
#else
	// constantly glowing only
	#define MASK (1<<MODE_BUTTON) | (1<<GND_PIN) | (1<<WLED_PIN)
#endif
	
//#define MASK (1<<MODE_BUTTON) | (1<<GND_PIN) | (1<<WLED_PIN)

void init_io();
void sendByte(unsigned char a);


void init_io(){
	#ifndef WLED_PIN
		DDRB=(1<<DATA_PIN) | (1<<CLK_PIN) | (1<<GND_PIN); 	
	#else
		DDRB=(1<<DATA_PIN) | (1<<CLK_PIN) | (1<<GND_PIN) | (1<<WLED_PIN); 	
	#endif
	PORTB=MASK;	
}

void sendByte(unsigned char a){
	unsigned char i, data, b;//, mask;
	//unsigned char mask;
	
	b=a;
	for (i=0; i<8; i++){
		data=DATA0;
		if (  (b&(1<<(7-i)))>0 ) data=DATA1;
	
		LED_PORT=data | CLOCK0 | MASK;
		LED_PORT=data | CLOCK1 | MASK;
	}
}

inline void startFrame(){
	sendByte(0);
	sendByte(0);
	sendByte(0);
	sendByte(0);
}

inline void endFrame(){
	sendByte(255);
	sendByte(255);
	sendByte(255);
	sendByte(255);
}

inline void sendRGB( unsigned char r, unsigned char g, unsigned char b ){
	sendByte(START_BYTE);	// initial
	
	sendByte(b);
	sendByte(g);
	sendByte(r);
}

inline void sendRGB_( struct RGB *a ){
	sendByte(START_BYTE);	// initial
	
	sendByte((*a).B);
	sendByte((*a).G);
	sendByte((*a).R);
}


inline void sendRGBpack( unsigned char n, rgb_pointer a[]  ){
	unsigned char i;
	
	startFrame();
	
	for (i=0; i<n; i++){
		sendRGB_(a[i]);
	}
	
	endFrame();	
	#if FRAME_DELAY>NO_DELAY
		_delay_ms(FRAME_DELAY);
	#endif
}

inline void sendRawRGBpack( unsigned char n, unsigned char r[], unsigned char g[], unsigned char b[], unsigned char mask[]  ){
	unsigned char i;
	
	startFrame();
	
	for (i=0; i<n; i++){
		if (mask[i+1]>0){
			sendRGB( r[i], g[i], b[i] );
		} else {
			sendRGB( 0,0,0 );
		}
	}
	
	endFrame();	
	#if FRAME_DELAY>NO_DELAY
		_delay_ms(FRAME_DELAY);
	#endif
}

#endif
