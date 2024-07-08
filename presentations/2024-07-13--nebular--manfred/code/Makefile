SOURCES := $(shell find . -name '*.gno')
PNGS := $(SOURCES:.gno=.png)

.PHONY: all
all: $(PNGS)

.SECONDEXPANSION:
%.png: $$(wildcard %.gno)
	carbon-now --config carbon-now.json --save-as $(basename $@) $<

clean:
	rm *.png

install:
	yarn global add carbon-now-cli
