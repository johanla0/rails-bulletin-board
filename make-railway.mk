prod-migrate:
	railway run bin/rails db:migrate db:migrate:with_data

logs-prod:
	railway logs
