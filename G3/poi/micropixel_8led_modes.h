// t45	attiny45	76800 prog
// mode pck for micropixel-8 poi


#include "../apa102-driver-2.c"

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

//modes
#define MODE_NUM	22	// modes are color schemes in new micropixel
#define S_NUM		17	// trace patterns

#define DEMO_S_NUM	14
#define DEMO_M_NUM	12

#define LED_NUM	PACK_SIZE

//#define PORT_MASK	((1<<BUTTON_1)+(1<<GND_PIN))

//void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
//void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );



#define LED1	1
#define LED2	2
#define LED3	4
#define LED4	8
#define LED5	16
#define LED6	32
#define LED7	64
#define LED8	128

void mode_1();
void mode_2();				
void mode_3();
void mode_4();
void mode_4_18();
void mode_5();
void mode_6();
void mode_7();			
void mode_8();
void mode_8_18();
void mode_9();			
void mode_10();					
void demo();
	void demo_long();
void heart();
void binary();
void svetobobr();

//unsigned char const_light( unsigned char sch,  unsigned char delay, unsigned char mask );

// somy service vars
rgb_pointer pack[PACK_SIZE];
rgb_pointer scheme[PACK_SIZE];

	rgb_pointer *pal;
	
// unsigned char bbb=0;





