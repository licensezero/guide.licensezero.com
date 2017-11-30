guide.html: guide.md head.html foot.html
	cat head.html > $@
	commonmark --smart $< >> $@
	cat foot.html >> $@
