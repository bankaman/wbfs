PROGS = negentig scrub wbfs 
COMMON = tools.o bn.o ec.o disc_usage_table.o libwbfs.o libwbfs_unix.o wiidisc.o rijndael.o
DEFINES = -DLARGE_FILES -D_FILE_OFFSET_BITS=64
LIBS = -lcrypto

CC = gcc
CFLAGS = -Wall -W -Ilibwbfs -I.
#CFLAGS += -O3 #optimisation
CFLAGS += -g #debug
#CFLAGS += -D_GNU_SOURCE

#CFLAGS = -Wall -m32 -W  -ggdb -Ilibwbfs -I.

# manually switch flags if you are on amd64 (should test that in makefile)
#LDFLAGS = -m32
#LDFLAGS = -m64 -L/usr/lib64



VPATH+=libwbfs
OBJS = $(patsubst %,%.o,$(PROGS)) $(COMMON)

all: $(PROGS)

$(PROGS): %: %.o $(COMMON) Makefile
	$(CC) $(CFLAGS) $(LDFLAGS) $< $(COMMON) $(LIBS) -o $@

$(OBJS): %.o: %.c tools.h Makefile
	$(CC) $(CFLAGS) $(DEFINES) -c $< -o $@ 

clean:
	-rm -f $(OBJS) $(PROGS)
