images: omninames omni-ping-server omni-ping-client

omninames:
	docker build -f Dockerfile-omninames -t omninames .

omni-ping-server:
	docker build -f Dockerfile-omni-ping-server -t omni-ping-server .

omni-ping-client:
	docker build -f Dockerfile-omni-ping-client -t omni-ping-client .

run-omninames: omninames
	docker run -itd --net=corba --name nameservice omninames

run-omni-ping-server: omni-ping-server
	docker run -it --rm --net=corba omni-ping-server

run-omni-ping-client: omni-ping-client
	docker run -it --rm --net=corba omni-ping-client
