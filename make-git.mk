BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

branch:
	git checkout $(ARGS) &> /dev/null || git checkout -b $(ARGS)
branch-reset:
	$(eval current_branch := $(BRANCH))
	git reset --hard origin/$(current_branch)
history:
	git log --oneline
pull:
	git pull origin $(BRANCH)
push:
	git push origin $(BRANCH)
uncommit:
	git reset --soft HEAD^
upd:
	git merge main --no-edit
