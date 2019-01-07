OUTPUT="./bin"
DEVELOPER_LIB="$(OUTPUT)/Toolchains/XcodeDefault.xctoolchain/usr/lib"

all: dylib loader kanye

prepare:
	mkdir -p $(OUTPUT)
	cp symbols $(OUTPUT)/
	mkdir -p $(DEVELOPER_LIB)

dylib: prepare
	clang \
		-dynamiclib -framework Foundation \
		osxinj/mach_inject.c injector.m \
		-o $(DEVELOPER_LIB)/libswiftDemangle.dylib
	clang \
		-dynamiclib osxinj/bootstrap.c \
		-o $(OUTPUT)/bootstrap.dylib
	clang -framework Foundation \
		-dynamiclib sip.m \
		-o $(OUTPUT)/sip.dylib

loader: prepare
	clang -framework Foundation exploit.m -o $(OUTPUT)/test

kanye: prepare
	swiftc -static-stdlib -o $(OUTPUT)/taytay taylor.swift

run: all
	sudo launchctl start com.apple.diskmanagementd # make sure it's running
	sudo $(OUTPUT)/test

clean:
	rm -rf $(OUTPUT)/*
