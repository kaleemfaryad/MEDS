CC = gcc

CFLAGS = -Wall -Wextra -std=c11

TARGET = decoder

OBJ = main.o decoder.o

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) -o $(TARGET)

main.o: main.c decoder.h
	$(CC) $(CFLAGS) -c main.c

decoder.o: decoder.c decoder.h
	$(CC) $(CFLAGS) -c decoder.c

clean:
	rm -f *.o $(TARGET)