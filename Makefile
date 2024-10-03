BIN = bin
ifeq ($(OS),Windows_NT)
	TARGET =inet.dll
	OS_FLAGS =-I . -lws2_32
else
    UNAME_S := $(shell uname -s)
	TARGET =inet.so
	OS_FLAGS =-I. -O2
	ifeq ($(UNAME_S),Darwin)
		TARGET = inet.dylib
	endif
endif

$(BIN)/$(TARGET): $(BIN) inet.c
	gcc -Wall  $(OS_FLAGS) -fPIC -shared inet.c -o $(BIN)/$(TARGET)

$(BIN):
	mkdir $(BIN)

clean:
	rm -rf $(BIN)/*

test: \
	$(BIN)/$(TARGET)
	./testsuite.sh
