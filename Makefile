vdirectory = ./v

install:
	$(MAKE) global-install
	$(MAKE) install-deps

global-install: | $(vdirectory)
	cd v && make && sudo ./v symlink

install-deps:
	# v install ui

$(vdirectory):
	@echo "V Folder does not exist"
	git clone https://github.com/vlang/v

start:
	v run src/main.v