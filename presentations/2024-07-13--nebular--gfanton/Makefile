# gno
GNO_COMMIT ?= feat/ws/webremote
GNO_ROOT ?= gno
GNO_REPO ?= github.com/gnolang/gno

git_gno := git -C $(GNO_ROOT)

all: deps

deps: $(GNO_ROOT) checkout _deps
_deps:
# install gno dev deps
	$(MAKE) -C $(GNO_ROOT)/misc/devdeps install
# install gno
	$(MAKE) -C $(GNO_ROOT) install

checkout:
	$(git_gno) cat-file -e $(GNO_COMMIT) || $(git_gno) fetch
	$(git_gno) checkout $(GNO_COMMIT) && $(git_gno) pull

update: $(GNO_ROOT)
	$(git_gno) pull	--rebase

cleanup:
	rm -rf $(GNO_ROOT)

.PHONY: update deps checkout

$(GNO_ROOT):
	git clone https://$(GNO_REPO) $@

