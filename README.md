##Команда для апуска контейнеров

	$ env $(cat .env | grep ^[^#] | xargs) docker-compose up
	