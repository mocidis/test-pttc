.PHONY: all clean

C_DIR := ../common
C_SRCS := ansi-utils.c

SERIAL_DIR := ../serial
SERIAL_SRCS := pttc_uart.c serial_utils.c

MAIN_DIR := .
MAIN_SRCS := main.c

APP := myapp-pttc

LIBS_DIR=../libs/linux-armv7l
EX:=arm-none-linux-gnueabi

#CFLAGS:=-fms-extensions $(shell pkg-config --cflags libpjproject)
CFLAGS:=-fms-extensions -DPJ_AUTOCONF=1 -O2 -DPJ_IS_BIG_ENDIAN=0 -DPJ_IS_LITTLE_ENDIAN=1 -I$(LIBS_DIR)/include
CFLAGS+= -g -I $(C_DIR)/include -I $(MAIN_DIR)/include -I $(SERIAL_DIR)/include
#LIBS:=$(shell pkg-config --libs libpjproject) -lpthread
LIBS:= -L$(LIBS_DIR)/lib -lpjsua-$(EX) -lpjsip-ua-$(EX) -lpjsip-simple-$(EX) -lpjsip-$(EX) -lpjmedia-codec-$(EX) -lpjmedia-$(EX) -lpjmedia-videodev-$(EX) -lpjmedia-audiodev-$(EX) -lpjmedia-$(EX) -lpjnath-$(EX) -lpjlib-util-$(EX) -lsrtp-$(EX) -lresample-$(EX) -lgsmcodec-$(EX) -lspeex-$(EX) -lilbccodec-$(EX) -lg7221codec-$(EX) -lportaudio-$(EX) -lpj-$(EX) -lm -lrt -lpthread

all: $(APP)

$(APP): $(MAIN_SRCS:.c=.o) $(C_SRCS:.c=.o) $(SERIAL_SRCS:.c=.o)
	@echo [LINK]: $@
	$(CC) -o $@ $^ $(LIBS)

$(MAIN_SRCS:.c=.o) : %.o : $(MAIN_DIR)/src/%.c
	@echo [CC]: $@
	$(CC) -o $@ -c $< $(CFLAGS)

$(SERIAL_SRCS:.c=.o) : %.o : $(SERIAL_DIR)/src/%.c
	@echo [CC]: $@
	$(CC) -o $@ -c $< $(CFLAGS)

$(C_SRCS:.c=.o) : %.o : $(C_DIR)/src/%.c
	@echo [CC]: $@
	$(CC) -o $@ -c $< $(CFLAGS)

clean:
	rm -fr *.o $(APP)
