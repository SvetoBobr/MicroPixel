// G0 apa102 led strip driver for attiny45 or pin-to-pin compatible MCU

#ifndef T45_APA102DRIVER_V1

#define T45_APA102DRIVER_V1

#include <avr/io.h>
#include <util/delay.h>

#ifndef LED_PORT
	#define LED_PORT PORTB
#endif

#ifndef DATA_PIN
	//#define DATA_PIN 0
	#warning "no DATA_PIN defined"
#endif
#ifndef CLK_PIN
	//#define CLK_PIN 1
	#warning "no CLK_PIN defined"
#endif
#ifndef GND_PIN
	//#define GND_PIN 2
	#warning "no GND_PIN defined"
#endif

#define DATA0	0
#define DATA1	(1<<DATA_PIN)
#define CLOCK0	0
#define CLOCK1	(1<<CLK_PIN)

#ifndef FRAME_DELAY
	#define FRAME_DELAY 100
	#warning "FRAME_DELAY set to default 100"
#endif

struct RGB{
	unsigned char R;
	unsigned char G;
	unsigned char B;
};

typedef  struct RGB* rgb_pointer;

#define MASK (1<<BUTTON_1)

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
/*
void sendByte(unsigned char a){
	unsigned char i, data, b, mask;
	//unsigned char mask;
	mask=LED_PORT & !(1<<DATA_PIN | 1<<CLK_PIN | 1<<GND_PIN );
	b=a;
	for (i=0; i<8; i++){
		data=DATA0;
		if (  (b&(1<<(7-i)))>0 ) data=DATA1;
	
		LED_PORT=data | CLOCK0 | mask;
		LED_PORT=data | CLOCK1 | mask;
		LED_PORT=data | CLOCK0 | mask;
	}
}
*/
void startFrame(){
	sendByte(0);
	sendByte(0);
	sendByte(0);
	sendByte(0);
}

void endFrame(){
	sendByte(255);
	sendByte(255);
	sendByte(255);
	sendByte(255);
}

void sendRGB( unsigned char r, unsigned char g, unsigned char b ){
	sendByte(255);	// initial
	
	sendByte(b);
	sendByte(g);
	sendByte(r);
}

void sendRGB_( struct RGB *a ){
	sendByte(255);	// initial
	
	sendByte((*a).B);
	sendByte((*a).G);
	sendByte((*a).R);
}

void sendRGBpack( unsigned char n, rgb_pointer a[]  ){
	unsigned char i;
	
	startFrame();
	
	for (i=0; i<n; i++){
		sendRGB_(a[i]);
	}
	
	endFrame();	
	_delay_ms(FRAME_DELAY);
}

#endif
