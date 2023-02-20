# Makefile - SimpleDeformableSurface

INCLUDES=-I../../../../include
INCLUDES+=-I../../../../libsrc/include
INCLUDES+=-I../../../../utilities/include
LDFLAGS=-L../../../../libsrc/lib -L../../../../utilities/lib

#DEBUG = TRUE

ifndef examples_dir
export examples_dir = /usr/share/3DTouch/examples
endif

examples_dir := $(examples_dir)/HL

ifdef DEBUG
CFG=SimpleDeformableSurface_Debug
else
CFG=SimpleDeformableSurface_Release
endif

CC=gcc
CFLAGS=
CXX=g++
CXXFLAGS=$(CFLAGS)

ifeq "$(CFG)"  "SimpleDeformableSurface_Release"
CFLAGS+=-W -fexceptions -O2 $(INCLUDES) -Dlinux -DNDEBUG
LD=$(CXX) $(CXXFLAGS)
LIBS+=-lHL -lHLU -lHD -lHDU -lglut -lrt
else

ifeq "$(CFG)"  "SimpleDeformableSurface_Debug"
CFLAGS+=-W -fexceptions -g -O0 $(INCLUDES) -Dlinux -D_DEBUG
LD=$(CXX) $(CXXFLAGS)
LIBS+=-lHL -lHLUD -lHD -lHDUD -lglut -lrt
endif
endif

ifndef TARGET
TARGET=SimpleDeformableSurface
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
	draw_string.cpp \
	HapticDeviceConstraint.cpp \
	main.cpp \
	MouseSpringConstraint.cpp \
	NailConstraint.cpp \
	OdeSolver.cpp \
	Particle.cpp \
	ParticleSystem.cpp \
	SpringConstraint.cpp \
	Surface.cpp \
	UnProjectUtilities.cpp

HEADER_FILES= \
	Constraint.h \
	draw_string.h \
	DynamicsMath.h \
	HapticDeviceConstraint.h \
	MouseSpringConstraint.h \
	NailConstraint.h \
	OdeSolver.h \
	Particle.h \
	ParticleSystem.h \
	SpringConstraint.h \
	Surface.h \
	UnProjectUtilities.h

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
	install -m 644 -o 0 -g 0 Makefile $(examples_dir)/graphics/$(TARGET)
	install -m 644 -o 0 -g 0 $(SRCS) $(examples_dir)/graphics/$(TARGET)
