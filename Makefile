include *.mk

.PHONY: app test spec lib docs bin config db tmp

# NOTE: Makes it possible to run "make aaa bbb" instead of "make aaa ARGS=bbb"
# See https://stackoverflow.com/a/47008498
ARGS = $(filter-out $@,$(MAKECMDGOALS))
%:
	@:
