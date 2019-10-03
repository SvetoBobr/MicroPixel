// t45	attiny45	76800 prog
// mode pck for micropixel-8 poi


#include "../apa102-driver-2.c"

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

//modes
#define MODE_NUM	22	// modes are color schemes in new micropixel
#define S_NUM		5	// trace patterns


#define LED_NUM	PACK_SIZE

//#define PORT_MASK	((1<<BUTTON_1)+(1<<GND_PIN))

//void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
//void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );



#define LED1	1
#define LED2	2
#define LED3	4
#define LED4	8

void mode_1();
void mode_2();				
void mode_3();
void mode_4();


//unsigned char const_light( unsigned char sch,  unsigned char delay, unsigned char mask );

// somy service vars
rgb_pointer pack[PACK_SIZE];
rgb_pointer scheme[PACK_SIZE];

	rgb_pointer *pal;
	
// unsigned char bbb=0;





