db:
	bin/rails db:migrate
db-rollback:
	bin/rails db:rollback STEP=1
db!:
	@ make db-reset
db-reset:
	RAILS_ENV=development bin/rails db:drop:_unsafe db:create db:migrate db:fixtures:load db:seed
	sleep 1
	RAILS_ENV=development bin/rails db:migrate:with_data
