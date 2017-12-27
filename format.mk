format: format_c format_perl

format_perl: urxvt/shellex.in
	cd $(shell dirname $^) && perltidy $(shell basename $^)

format_c: preload/main.c
	clang-format -i $^

.PHONY: format format_c format_perl
