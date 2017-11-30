COMMONMARK=node_modules/.bin/commonmark

guide.html: guide.md head.html foot.html | $(COMMONMARK)
	cat head.html > $@
	$(COMMONMARK) --smart $< >> $@
	cat foot.html >> $@

$(COMMONMARK):
	npm install
