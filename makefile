default:
	@docker build -t carwow/elixir .

upload:
	@docker push carwow/elixir
