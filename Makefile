LISP_FILES = $(shell find . -type f -name '*.el')
COMPILED_LISP_FILES = $(patsubst %.el,%.elc,$(LISP_FILES))

%.elc: %.el
	emacs --batch --eval '(if (not (byte-compile-file "$<")) (error "compilation error"))' > $@

all: compile_all

compile_all: $(COMPILED_LISP_FILES)

clean:
	rm -f $(COMPILED_LISP_FILES)

.PHONY: compile_all clean all
