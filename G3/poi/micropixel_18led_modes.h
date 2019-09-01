// t45	attiny45	38400 prog
// board	MMCU		programm_after_make
//38400
//

#include "../apa102-driver-2.c"

void formColorPack( unsigned char n, struct RGB* color, rgb_pointer pack[], unsigned char mask  );
void formColorPack_scheme( unsigned char n, rgb_pointer color[], rgb_pointer pack[], unsigned char mask  );

//modes
#define MODE_NUM	19	// modes are color schemes in new micropixel
#define S_NUM		11	// trace patterns

#define DEMO_S_NUM	8
#define DEMO_M_NUM	12

#define LED_NUM	PACK_SIZE

// somy service vars
//rgb_pointer pack[PACK_SIZE];
//rgb_pointer scheme[PACK_SIZE];
unsigned char r[PACK_SIZE];
unsigned char g[PACK_SIZE];
unsigned char b[PACK_SIZE];
unsigned char mask[PACK_SIZE+1];

	rgb_pointer *pal;
	

void mode_1();
void mode_2();				
inline void mode_3();
inline void mode_4();
inline void mode_5();
inline void mode_6();
inline void mode_7();			
inline void mode_8();
//inline void mode_9();			
inline void svetobobr();					
inline void demo();	
inline void binary();

//inline unsigned char const_light( unsigned char sch,  unsigned char delay );
