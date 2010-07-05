LISP_FILES = $(shell find . host -type f -name '*.el' -maxdepth 1)
COMPILED_LISP_FILES = $(patsubst %.el,%.elc,$(LISP_FILES))

%.elc: %.el
	emacs --batch --eval '(progn (add-to-list (quote load-path) "$(PWD)/packages") (if (not (byte-compile-file "$<")) (error "compilation error")))' > $@

all: compile_all

compile_all: $(COMPILED_LISP_FILES)

clean:
	rm -f $(COMPILED_LISP_FILES)

.PHONY: compile_all clean all
