assets:
	bin/rails assets:precompile
c:
	bin/rails console -- --noautocomplete
routes:
	bin/rails routes | grep "$(ARGS)"
test:
	bin/rails test $(ARGS)
s: server
server:
	bin/rails s
