LISP_FILES = $(shell find . -type f -name '*.el')
COMPILED_LISP_FILES = $(patsubst %.el,%.elc,$(LISP_FILES))

%.elc: %.el
	emacs --batch --eval '(byte-compile-file "$<")' > $@

compile_all: $(COMPILED_LISP_FILES)

clean:
	rm -f $(COMPILED_LISP_FILES)

all: compile_all

.PHONY: compile_all
