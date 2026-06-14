# this config for windows compilation code
# all:
# 	g++ -Iinc -Llib 75.cpp -lmingw32 -lSDL2main -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_mixer -o 75.exe
# this code for linx fedora :
CXX = g++
CXXFLAGS = -Wall -std=c++17
SRC =75.cpp
TARGET = mygame

SDL_FLAGS = $(shell pkg-config --cflags --libs sdl2 SDL2_image SDL2_ttf SDL2_mixer)

all:
	$(CXX) $(CXXFLAGS) $(SRC) $(SDL_FLAGS) -o $(TARGET)

clean:
	rm -f $(TARGET)

