VERSION=0.9.3

.PHONY: build
build:
	docker build --platform linux/amd64 -t robinthrift/baikal:$(VERSION)-nginx .

.PHONY: run
run:
	docker run --rm -p 8080:80 --platform linux/amd64 --name baikal-test robinthrift/baikal:$(VERSION)-nginx


.PHONY: push
push: build
	docker push robinthrift/baikal:$(VERSION)-nginx
