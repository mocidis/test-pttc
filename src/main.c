#include "pttc_uart.h"
#include "ansi-utils.h"

int main(int n, char *opts[]) {
    serial_t serial;
    pttc_t pttc;
    if(n < 2) {
        fprintf(stdout, "Usage: myapp-pttc <device>\n");
        exit(-1);
    }

    pttc_init(&serial, &pttc, NULL);

    pttc_start(&serial, opts[1]);
    
    my_pause();

    pttc_end(&serial);

    return 0;
}
