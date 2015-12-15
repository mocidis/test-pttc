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

    pj_caching_pool cp;
    pj_pool_t *pool;

    pj_init();
    pj_caching_pool_init(&cp, NULL, 1024);
    pool = pj_pool_create(&cp.factory, "pool", 6400, 6400, NULL);

    pttc_init(&serial, &pttc, on_pttc_ptt, pool);

    pttc_start(&serial, opts[1]);
    
    my_pause();

    pttc_end(&serial);

    return 0;
}
