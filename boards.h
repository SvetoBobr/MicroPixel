#ifndef BOARD
	#define BOARD TEST_PROTO
	#warning "BOARD not defined - using default TEST"
#endif

#define	TEST_PROTO	1
#define	GCDV		2
#define	GDCV		3
		
#define T45			1		

#include <avr/io.h>

#ifndef CPU_TYPE
	#error "NO CPU"
#elif CPU_TYPE==T45
	//default buttons
	#ifndef BUTTON_PIN
		#define BUTTON_PIN	PINB
		#define LED_PORT PORTB
	#endif
#else
	#ifndef BUTTON_PIN
		#define BUTTON_PIN	PINB
		#define LED_PORT PORTB
	#endif	
#endif


#if BOARD==TEST_PROTO	// 
	// LED Strip
	#define GND_PIN 	0	// 2 //key to connect led's ground
	#define DATA_PIN	2	// 0
	#define CLK_PIN		1	// 1
	
	#define MODE_BUTTON	4
	
#elif BOARD==GDCV	// GND-CLCK-DATA-VCC - 
	// LED Strip
	#define GND_PIN 	2	// 2 //key to connect led's ground
	#define DATA_PIN	1	// 0
	#define CLK_PIN		0	// 1
	#define MODE_BUTTON	4
	#warning GDCV
#elif BOARD==GCDV	// GND-DATA-CLCK-VCC - 
	// LED Strip
	#define GND_PIN 	2	// 2 //key to connect led's ground
	#define DATA_PIN	0	// 1
	#define CLK_PIN		1	// 0
	#define MODE_BUTTON	4	
	#warning GCDV
#endif

#ifndef BUTTON_1
	#ifndef MODE_BUTTON
		#error "NO BUTONS DEFINED"
	#else
		#define BUTTON_1	MODE_BUTTON
	#endif
#endif
