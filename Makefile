.PHONY: docker-hotrod
docker-hotrod:
	docker build . --platform linux/amd64 -t public.ecr.aws/pyroscope/hotrod-golang:latest
