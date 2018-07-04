COMMONMARK=node_modules/.bin/commonmark
DOTS=$(wildcard *.dot)

index.html: index.md head.html foot.html $(DOTS:.dot=.svg) | $(COMMONMARK)
	cat head.html > $@
	$(COMMONMARK) --smart $< >> $@
	cat foot.html >> $@

%.svg: %.dot
	dot -Tsvg < $< > $@

$(COMMONMARK):
	npm install
