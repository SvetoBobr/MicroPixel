



inline void make_serie(){
	switch (serie){
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
		
		switch (serie){
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
		switch (serie){
			case 9:
				svetobobr();
				break;;							
			case 10:
				binary();
				break;;
			case 11:
				demo();
				break;;
		}
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
	const_light(mode, 10 );
}

void mode_2(){	// strob
	//unsigned char i;
	fill_mask();
	const_light(mode, 10 );

	//flush_mask();
	const_light(0, 10 );
}

void mode_3(){	// gears
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<=9 ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 10 );
	
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<=9 ) mask[i]=0; else mask[i]=1;
	}
	const_light(mode, 10 );
}

void mode_4(){	// not really flower
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i==1 || i==LED_NUM-a || i==1 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	if (++a>LED_NUM) a=0;
}

void mode_5(){	// flower
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( i<=a || i==0 || i==LED_NUM) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	if (++a>LED_NUM) a=0;
}

void mode_6(){	// chess
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( ((i+a) & 2)>0 ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	a++; a++;
	if (a>2) a=0;
}

void mode_7(){	// romb
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( ((i>a) && (i<(LED_NUM-a+1))) || (i==1) || (i==18) ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	if (++a>9-1) a=0;
}

void mode_8(){
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( (((i+a) & 2)>0) || (i==1) || (i==18) ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 1 );
	a++;
	if (a>LED_NUM) a=0;
}

void _S(){
	flush_mask(); mask[3]=mask[4]=mask[5]=mask[6]=mask[16]=1;
	const_light(mode, 1);
	flush_mask(); mask[2]=mask[7]=mask[17]=1;
	const_light(mode, 1);
	flush_mask(); mask[1]=mask[8]=mask[18]=1;
	const_light(mode,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(mode,3);
	flush_mask(); mask[1]=mask[10]=mask[18]=1;
	const_light(mode,1);
	flush_mask(); mask[1]=mask[11]=mask[18]=1;
	const_light(mode,1);
	flush_mask(); mask[1]=mask[12]=mask[18]=1;
	const_light(mode,1);
	flush_mask(); mask[3]=mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(mode,1);
	flush_mask();
	const_light(mode, 4);
}

void _V(){
	flush_mask(); mask[1]=mask[2]=mask[3]=mask[4]=1;
	const_light(mode,1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=1;
	const_light(mode,1);
	flush_mask(); mask[9]=mask[10]=mask[11]=mask[12]=1;
	const_light(mode,1);
	flush_mask(); mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(mode,1);
	
	flush_mask(); mask[17]=mask[18]=1;
	const_light(mode,1);
	
	flush_mask(); mask[13]=mask[14]=mask[15]=mask[16]=1;
	const_light(mode,1);
	flush_mask(); mask[9]=mask[10]=mask[11]=mask[12]=1;
	const_light(mode,1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=1;
	const_light(mode,1);
	flush_mask(); mask[1]=mask[2]=mask[3]=mask[4]=1;
	const_light(mode,1);
		flush_mask();
	const_light(mode, 4);
}

void _E(){
	fill_mask();
	const_light(mode,1);
	flush_mask(); mask[1]=mask[8]=mask[18]=1;
	const_light(mode,15);
		flush_mask();
	const_light(mode, 4);
}

void _T(){
	flush_mask(); mask[1]=1;
	const_light(mode,6);
	fill_mask();
	const_light(mode,1);
	flush_mask(); mask[1]=1;
	const_light(mode,6);
		flush_mask();
	const_light(mode, 4);
}

void _O(){
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=mask[9]=mask[10]=mask[11]=mask[12]=mask[13]=mask[14]=1;
	const_light(mode, 1);	
	flush_mask(); mask[3]=mask[4]=mask[15]=mask[16]=1;
	const_light(mode, 1);
	flush_mask(); mask[2]=mask[17]=1;
	const_light(mode,1);
	flush_mask(); mask[1]=mask[18]=1;
	const_light(mode,3);
	flush_mask(); mask[2]=mask[17]=1;
	const_light(mode,1);
	flush_mask(); mask[3]=mask[4]=mask[15]=mask[16]=1;
	const_light(mode, 1);
	flush_mask(); mask[5]=mask[6]=mask[7]=mask[8]=mask[9]=mask[10]=mask[11]=mask[12]=mask[13]=mask[14]=1;
	const_light(mode, 1);	
	flush_mask(); 
	const_light(mode, 4);
}

void _B(){
	fill_mask();
	const_light(mode,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(mode,4);
	flush_mask(); mask[2]=mask[8]=mask[10]=mask[17]=1;
	const_light(mode,2);
	fill_mask(); mask[1]=mask[2]=mask[8]=mask[9]=mask[10]=mask[17]=mask[18]=0;
	const_light(mode,1);
	
	flush_mask(); 
	const_light(mode, 4);
}

void _R(){
	fill_mask();
	const_light(mode,1);
	flush_mask(); mask[1]=mask[9]=mask[18]=1;
	const_light(mode,3);
	flush_mask(); mask[2]=mask[8]=mask[10]=mask[11]=1;
	const_light(mode,1);
	flush_mask(); mask[2]=mask[8]=mask[12]=mask[13]=1;
	const_light(mode,1);
	flush_mask(); mask[3]=mask[4]=mask[5]=mask[6]=mask[7]=1;
	mask[14]=mask[15]=mask[16]=mask[17]=mask[18]=1;
	const_light(mode,1);
	
	flush_mask(); 
	const_light(mode, 4);
}

void blank(){
	flush_mask();
	const_light(mode, 15 );
}

void svetobobr(){	//	svetobobr
	_S(); 
	_V(); 
	_E(); 
	_T(); 
	_O(); 
	_B(); 
	_O(); 
	_B(); 
	_R();
	blank();
}


		
void binary(){
	unsigned static a;
	unsigned char i;
	for ( i=1; i<=LED_NUM; i++ ) {
		if ( (i & a)>0 ) mask[i]=1; else mask[i]=0;
	}
	const_light(mode, 10 );
	if (++a>LED_NUM) a=0;
}

#define SP_L	2
#define	SB_L	1

void demo(){
	static unsigned char ds=1;
	static unsigned char dm=1;
	unsigned char rs=1;
	unsigned char rm=1;

	rm=mode;
	mode=dm;
	rs=serie;
	serie=ds;
	make_serie();
	mode=rm;
	serie=rs;
	
	if (++dm>DEMO_M_NUM){
		dm=1;
		
		if (++ds>DEMO_S_NUM){
			ds=1;
		}
	}
}
