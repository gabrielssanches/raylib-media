.PHONY: all clean run

BUILD_PATH ?= build

RAYLIB_INCLUDE_PATH   ?= ../raylib/src
RAYLIB_LIB_PATH       ?= ../raylib/src

CC ?= gcc
AR ?= ar
CFLAGS_DEBUG ?= -gdwarf-2
CFLAGS_OPT ?= -O2

CFLAGS = -std=gnu99 -Wall -Wno-missing-braces -Wunused-result -D_DEFAULT_SOURCE
#CFLAGS += -Werror
CFLAGS += $(CFLAGS_DEBUG)
CFLAGS += $(CFLAGS_OPT)
INCLUDE_PATHS = -I./src -I$(RAYLIB_INCLUDE_PATH)
LDFLAGS = -L$(BUILD_PATH)
LDFLAGS += -L$(RAYLIB_LIB_PATH)

LDLIBS = -lraylib -lavcodec -lavformat -lavutil -lswresample -lswscale
LDLIBS += -lX11
LDLIBS += -lm

RMEDIA_SRC = src/rmedia.c

EXAMPLES_SRC = \
	example_01_basics.c \
	example_02_media_player.c \
	example_03_multi_stream.c \
	example_04_custom_stream.c \

ALL_SRC = $(RMEDIA_SRC) $(EXAMPLES_SRC)

all:
	make $(BUILD_PATH)/librmedia.a
	make $(BUILD_PATH)/example_01_basics
	make $(BUILD_PATH)/example_02_media_player
	make $(BUILD_PATH)/example_03_multi_stream
	make $(BUILD_PATH)/example_04_custom_stream

$(BUILD_PATH):
	mkdir -p $(BUILD_PATH)/src
	mkdir -p $(BUILD_PATH)/examples/media
	ln -s ../examples/media/resources/ $(BUILD_PATH)/resources

$(BUILD_PATH)/librmedia.a: $(BUILD_PATH) $(BUILD_PATH)/src/rmedia.o
	$(AR) rcs $(BUILD_PATH)/librmedia.a $(BUILD_PATH)/src/rmedia.o

$(BUILD_PATH)/example_01_basics: $(BUILD_PATH)/librmedia.a $(BUILD_PATH)/examples/media/example_01_basics.o
	$(CC) -o $@ $(BUILD_PATH)/examples/media/example_01_basics.o $(CFLAGS) $(INCLUDE_PATHS) $(LDFLAGS) -lrmedia $(LDLIBS)

$(BUILD_PATH)/example_02_media_player: $(BUILD_PATH)/librmedia.a $(BUILD_PATH)/examples/media/example_02_media_player.o
	$(CC) -o $@ $(BUILD_PATH)/examples/media/example_02_media_player.o $(CFLAGS) $(INCLUDE_PATHS) $(LDFLAGS) -lrmedia $(LDLIBS)

$(BUILD_PATH)/example_03_multi_stream: $(BUILD_PATH)/librmedia.a $(BUILD_PATH)/examples/media/example_03_multi_stream.o
	$(CC) -o $@ $(BUILD_PATH)/examples/media/example_03_multi_stream.o $(CFLAGS) $(INCLUDE_PATHS) $(LDFLAGS) -lrmedia $(LDLIBS)

$(BUILD_PATH)/example_04_custom_stream: $(BUILD_PATH)/librmedia.a $(BUILD_PATH)/examples/media/example_04_custom_stream.o
	$(CC) -o $@ $(BUILD_PATH)/examples/media/example_04_custom_stream.o $(CFLAGS) $(INCLUDE_PATHS) $(LDFLAGS) -lrmedia $(LDLIBS)

$(BUILD_PATH)/%.o: %.c
	$(CC) -c $< -o $@ $(CFLAGS) $(INCLUDE_PATHS)

# all source files are dependent on Makefile
$(ALL_SRC): Makefile
	[ -e $@ ] && touch $@ || true

clean:
	rm -rf _build*
