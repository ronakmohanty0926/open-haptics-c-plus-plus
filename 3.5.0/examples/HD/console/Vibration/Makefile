CC=gcc
CFLAGS+=-W -O2 -DNDEBUG -Dlinux
LIBS = -lHDU -lHD -lrt -lncurses -lstdc++ -lm

TARGET=Vibration
HDRS=
SRCS=Vibration.c conio.c
OBJS=$(SRCS:.c=.o)

.PHONY: all
all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $@ $(SRCS) $(LIBS)

.PHONY: clean
clean:
	-rm -f $(OBJS) $(TARGET)
