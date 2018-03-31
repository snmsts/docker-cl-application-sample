PROJECT=`basename "$(PWD)"`
FILES = app.ros build test

all:
	echo !
install: mount/ $(FILES:%=docker-cl-pack/home/%)
	cd docker-cl-pack; make PROJECT=$(PROJECT) base
	mkdir -p docker-cl-pack/home/.roswell
	echo "(ignore-errors (eval (read-from-string \"(pushnew #P\\\"/mnt/parent/mount\\\" ql:*local-project-directories*)\")))" > docker-cl-pack/home/.roswell/init.lisp
mount/:
	mkdir -p mount
docker-cl-pack/home/%: mount/ docker-cl-pack/
	rm -f $@ `basename "$@"`
	if [ -f mount/`basename "$@"` ]; then \
		ln -s mount/`basename "$@"` `basename "$@"`; \
	else \
		ln -s default/`basename "$@"` `basename "$@"`; \
	fi
	mkdir -p docker-cl-pack/home
	ln -s /mnt/parent/`basename "$@"` $@ || true
docker-cl-pack/:
	git clone https://github.com/snmsts/docker-cl-pack.git || true
deploy:
	@cd mount; make PROJECT=$(PROJECT) $@
%:
	@cd docker-cl-pack; make PROJECT=$(PROJECT) $@
