#include "pttc_uart.h"
#include "ansi-utils.h"
#include <stdio.h>
void on_pttc_ptt(int ptt) {
    fprintf(stdout, "PTTC - ptt is %d\n", ptt);
}
int main(int n, char *opts[]) {
    serial_t serial;
    pttc_t pttc;
    if(n < 2) {
        fprintf(stdout, "Usage: myapp-pttc <device>\n");
        exit(-1);
    }

    pttc_init(&serial, &pttc, on_pttc_ptt);

    pttc_start(&serial, opts[1]);
    
    my_pause();

    pttc_end(&serial);

    return 0;
}
