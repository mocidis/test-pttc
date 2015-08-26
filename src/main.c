#include "pttc_uart.h"
#include "ansi-utils.h"

int main(int n, char *opts[]) {
    pthread_t thread;

    if(n < 2) {
        fprintf(stdout, "Usage: myapp-pttc <device>\n");
        exit(-1);
    }

    pttc_init(NULL);

    pttc_start(opts[1], &thread);
    
    my_pause();

    pttc_end(&thread);

    return 0;
}
