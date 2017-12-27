format: format_c format_perl format_vim

format_perl: urxvt/shellex.in
	cd $(shell dirname $^) && perltidy $(shell basename $^)

format_c: preload/main.c
	clang-format -i $^

format_vim:
	for mkfile in $(wildcard *.mk) $(wildcard */*.mk) Makefile; do ./indent.sh $${mkfile} ; done
	for shfile in $(wildcard conf/*) shellex.in ; do ./indent.sh ${{shfile}} ; done
	./indent.sh .travis.yml

.PHONY: format format_c format_perl format_vim
