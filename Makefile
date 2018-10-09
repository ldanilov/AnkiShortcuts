include env.make

SPOON=AnkiShortcuts

default: Spoons/$(SPOON).spoon.zip

.PHONY: clean docs reinstall

clean:
	rm -f Spoons/$(SPOON).spoon.zip

Spoons/$(SPOON).spoon.zip: docs Source/$(SPOON).spoon
	rm -f Spoons/$(SPOON).spoon.zip
	cd Source ; /usr/bin/zip -9 -r ../Spoons/$(SPOON).spoon.zip $(SPOON).spoon

docs:
	mkdir -p .docs_tmp
	$(HAMMERSPOON_REPO)/scripts/docs/bin/build_docs.py \
	    --templates doc_templates \
		--output_dir .docs_tmp \
		--json \
		--markdown \
		--standalone \
		Source
	cat .docs_tmp/markdown/AnkiShortcuts.md .docs_tmp/markdown/index.md > README.md
	mv .docs_tmp/docs.json Source/$(SPOON).spoon/
	rm -rf .docs_tmp

reinstall: default
	mkdir -p .install_tmp
	/usr/bin/unzip Spoons/$(SPOON).spoon.zip -d .install_tmp
	open .install_tmp/$(SPOON).spoon
	rm -rf .install_tmp
