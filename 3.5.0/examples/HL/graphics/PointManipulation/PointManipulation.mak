# Makefile - PointManipulation

INCLUDES=-Iinclude
INCLUDES+=-I../include
INCLUDES+=-I../../../../include
INCLUDES+=-I../../../../libsrc/include
INCLUDES+=-I../../../../utilities/include
LDFLAGS=-L../../../../libsrc/lib -L../../../../utilities/lib

#DEBUG = TRUE

ifndef examples_dir
export examples_dir = /usr/share/3DTouch/examples
endif

examples_dir := $(examples_dir)/HL

ifdef DEBUG
CFG=PointManipulation_Debug
else
CFG=PointManipulation_Release
endif

CC=gcc
CFLAGS=
CXX=g++
CXXFLAGS=$(CFLAGS)

ifeq "$(CFG)"  "PointManipulation_Release"
CFLAGS+=-W -fexceptions -O2 $(INCLUDES) -Dlinux -DNDEBUG
LD=$(CXX) $(CXXFLAGS)
LIBS+=-lHL -lHLU -lHD -lHDU -lglut -lrt
else

ifeq "$(CFG)"  "PointManipulation_Debug"
CFLAGS+=-W -fexceptions -g -O0 $(INCLUDES) -Dlinux -D_DEBUG
LD=$(CXX) $(CXXFLAGS)
LIBS+=-lHL -lHLUD -lHD -lHDUD -lglut -lrt
endif
endif

ifndef TARGET
TARGET=PointManipulation
endif

.PHONY: all
all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<

%.o: %.cxx
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<


SOURCE_FILES= \
	src/HapticManager.cpp \
	src/PointManager.cpp \
	src/PointManipulation.cpp \
	src/PointManipulationAfx.cpp \
	src/ViewManager.cpp

HEADER_FILES= \
	include/HapticManager.h \
	include/PointManager.h \
	src/PointManipulationAfx.h \
	include/ViewManager.h

SRCS=$(SOURCE_FILES) $(HEADER_FILES)

OBJS=$(patsubst %.rc,%.res,$(patsubst %.cxx,%.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(filter %.c %.cc %.cpp %.cxx %.rc,$(SRCS)))))))

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

.PHONY: clean
clean:
	-rm -f $(OBJS) $(TARGET)

.PHONY: install
install:
	install -m 755 -o 0 -g 0 -d $(examples_dir)/graphics/$(TARGET)
	install -m 755 -o 0 -g 0 -d $(examples_dir)/graphics/$(TARGET)/src
	install -m 755 -o 0 -g 0 -d $(examples_dir)/graphics/$(TARGET)/include
	install -m 644 -o 0 -g 0 Makefile $(examples_dir)/graphics/$(TARGET)
	install -m 644 -o 0 -g 0 $(SOURCE_FILES) $(examples_dir)/graphics/$(TARGET)/src
	install -m 644 -o 0 -g 0 $(HEADER_FILES) $(examples_dir)/graphics/$(TARGET)/include




