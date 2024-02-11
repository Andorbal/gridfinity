# match "module foobar() { // `make` me"
TARGETS=$(shell sed '/^module [a-z0-9_-]*().*make me.*$$/!d;s/module /build\//;s/().*/.3mf/' bq-cc17.scad)

all: ${TARGETS}

# auto-generated .scad files with .deps make make re-build always. keeping the
# scad files solves this problem. (explanations are welcome.)
.SECONDARY: $(shell echo "${TARGETS}" | sed 's/\.3mf/.scad/g')

# explicit wildcard expansion suppresses errors when no files are found
include $(wildcard build/*.deps)

build/%.scad:
	mkdir -p $(@D)
	echo 'use <../bq-cc17.scad>\n$*();' > $@

build/%.3mf: build/%.scad
	openscad -m make -o $@ -d $@.deps $<