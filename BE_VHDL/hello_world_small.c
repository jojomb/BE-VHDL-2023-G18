// essai projet leds boutons

#include "sys/alt_stdio.h"
#include <stdio.h>
#include "system.h"
#include "altera_avalon_pio_regs.h" // pour éviter de renseigner les adresses physiques des périphériques
#include "unistd.h" 				// pour la fonction délai

#define boutons (volatile char *) BOUTONS_BASE
#define leds (unsigned int*) LEDS_BASE
unsigned int a;

int main()
{
  alt_putstr("Salut ext!\n");		// test si communication OK

  while (1)
  	  {
	  alt_putstr("Salut int!\n");	// test si communication OK
	  //*leds = *boutons;
	  a = *boutons & 3;
	  printf("boutons = %d \n", a);
	  usleep(1000000);
	  switch(a)
	  	  	  {
	  	  	  	  case 0 : *leds=0; break;
	  	  	  	  case 1 : *leds=0; break;
	  	  	  	  case 2 : break;
	  	  	  	  case 3 : *leds=*leds + 1; break;
	  	  	  	  default : *leds = 0; break;
	  	  	  }
	  }
	  //*leds = 0x0F;
	  //usleep(1000000);
	  //*leds = 0xF0;
	  //usleep(1000000);
  	  //}
  return 0;
}
