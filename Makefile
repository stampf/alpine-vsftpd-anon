NAME=nicolasstampf/alpine-vsftpd-anon
VOLUME=images

all:	build

build:	Dockerfile vsftpd.conf
	docker build -t $(NAME) .
	docker volume create $(VOLUME)
	touch .build

test:	.build
	docker run -d -p 20:20 -p 21:21 -p 10000-10010:10000-10010 --volume=$(VOLUME):/data/images --rm $(NAME) 

run:	.build
	docker run -d -p 20:20 -p 21:21 -p 10000-10010:10000-10010 --volume=$(VOLUME):/data/images --restart=always $(NAME)

push:
	docker login
	docker push $(NAME)

clean:
	rm .build
