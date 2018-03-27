PROJECT=`basename "$(PWD)"`
all:
	echo !
install:
	git clone https://github.com/snmsts/docker-cl-pack.git || true
	cd docker-cl-pack; make PROJECT=$(PROJECT) base
	mkdir -p docker-cl-pack/home/.roswell
	echo "(pushnew #P\"/mnt/parent/mount\" ql:*local-project-directories*)" > docker-cl-pack/home/.roswell/init.lisp
	mkdir -p mount
	rm -f docker-cl-pack/home/app.ros
	ln -s /mnt/parent/app.ros docker-cl-pack/home/app.ros || true
%:
	@cd docker-cl-pack; make PROJECT=$(PROJECT) $@
