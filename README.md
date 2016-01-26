##Команда для апуска контейнеров

	$ env `cat ./conf/.env | grep ^[^#] | xargs` docker-compose up
	
	
	env $(cat .env | grep ^[^#] | xargs) docker-compose up