INSTALL_PATH = /usr/local/bin/sasha

install:
	swift package --enable-prefetching update
	swift build --enable-prefetching -c release -Xswiftc -static-stdlib
	cp -f .build/release/Sasha $(INSTALL_PATH)
	cp -f project.sasha $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
