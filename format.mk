format: format_c format_perl format_vim

format_perl: urxvt/shellex.in
	echo "[FORMAT] $^"
	cd $(shell dirname $^) && perltidy $(shell basename $^)

format_c: preload/main.c
	echo "[FORMAT] $^"
	clang-format -i $^

format_vim:
	echo "[FORMAT]"
	for mkfile in $(wildcard *.mk) $(wildcard */*.mk) Makefile; do echo "[FORMAT] $${mkfile}"; ./indent.sh $${mkfile}; done
	for shfile in $(wildcard conf/*) shellex.in; do echo "[FORMAT] $${shfile}"; ./indent.sh $${shfile}; done
	echo "[FORMAT] .travis.yml"
	./indent.sh .travis.yml

.PHONY: format format_c format_perl format_vim
