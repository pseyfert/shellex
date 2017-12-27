#!/bin/sh
vim -f +"set softtabstop=2" +"set tabstop=2" +"set shiftwidth=2" +"set expandtab" +"gg=G" +":x" $@
