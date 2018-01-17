BINARY?=sasha
BUILD_FOLDER?=.build
OS?=sierra
PREFIX?=/usr/local
PROJECT?=Sasha
RELEASE_BINARY_FOLDER?=$(BUILD_FOLDER)/release/$(PROJECT)
VERSION?=2.1

build:
	swift build --disable-sandbox -c release -Xswiftc -static-stdlib -Xswiftc "-target" -Xswiftc "x86_64-apple-macosx10.12"

test:
	swift test

clean:
	swift package clean
	rm -rf $(BUILD_FOLDER) $(PROJECT).xcodeproj

xcodeproj:
	swift package generate-xcodeproj --xcconfig-overrides Config.xcconfig

install: build
	mkdir -p $(PREFIX)/bin
	cp -f $(RELEASE_BINARY_FOLDER) $(PREFIX)/bin/$(BINARY)
	cp -a .sasha ~

bottle: clean build
	mkdir -p $(BINARY)/$(VERSION)/bin
	cp README.md $(BINARY)/$(VERSION)/README.md
	cp LICENSE $(BINARY)/$(VERSION)/LICENSE
	cp -f $(RELEASE_BINARY_FOLDER) $(BINARY)/$(VERSION)/bin/$(BINARY)
	tar cfvz $(BINARY)-$(VERSION).$(OS).bottle.tar.gz --exclude='*/.*' $(BINARY)
	shasum -a 256 $(BINARY)-$(VERSION).$(OS).bottle.tar.gz
	rm -rf $(BINARY)

sha256:
	wget https://github.com/artemnovichkov/$(PROJECT)/archive/$(VERSION).tar.gz -O $(PROJECT)-$(VERSION).tar.gz
	shasum -a 256 $(PROJECT)-$(VERSION).tar.gz
	rm $(PROJECT)-$(VERSION).tar.gz
