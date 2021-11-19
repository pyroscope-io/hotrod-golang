.PHONY: docker-hotrod
docker-hotrod:
	docker build . --platform linux/amd64 -t kolenikovae/hotrod-golang:dev
