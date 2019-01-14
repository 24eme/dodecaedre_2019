all: bin/config.sh penta-cube-2019.svg
	bash bin/generate.sh

bin/config.sh:
	cp bin/config.sh.example bin/config.sh
