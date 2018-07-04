COMMONMARK=node_modules/.bin/commonmark
DOTS=$(wildcard *.dot)

index.html: index.md head.html foot.html figures | $(COMMONMARK)
	cat head.html > $@
	$(COMMONMARK) --smart $< >> $@
	cat foot.html >> $@

figures: $(DOTS:.dot=.svg)

%.svg: %.dot
	dot -Tsvg < $< > $@

$(COMMONMARK):
	npm install
