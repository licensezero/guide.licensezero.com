COMMONMARK=node_modules/.bin/commonmark

index.html: index.md head.html foot.html | $(COMMONMARK)
	cat head.html > $@
	$(COMMONMARK) --smart $< >> $@
	cat foot.html >> $@

$(COMMONMARK):
	npm install
