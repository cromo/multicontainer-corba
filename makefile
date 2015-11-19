images: omninames omni-ping-server omni-ping-client

iiopnet-ping-client:
	docker build -f Dockerfile-iiopnet-ping-client -t iiopnet-ping-client .

jacorb-ping-server:
	docker build -f Dockerfile-jacorb-ping-server -t jacorb-ping-server .

jacorb-ping-client:
	docker build -f Dockerfile-jacorb-ping-client -t jacorb-ping-client .

omninames:
	docker build -f Dockerfile-omninames -t omninames .

omni-ping-server:
	docker build -f Dockerfile-omni-ping-server -t omni-ping-server .

omni-ping-client:
	docker build -f Dockerfile-omni-ping-client -t omni-ping-client .

tao-ping-server:
	docker build -f Dockerfile-tao-ping-server -t tao-ping-server .

tao-ping-client:
	docker build -f Dockerfile-tao-ping-client -t tao-ping-client .

run-iiopnet-ping-client: iiopnet-ping-client
	docker run -it --rm --net=corba iiopnet-ping-client

run-jacorb-ping-server: jacorb-ping-server
	docker run -it --rm --net=corba jacorb-ping-server

run-jacorb-ping-client: jacorb-ping-client
	docker run -it --rm --net=corba jacorb-ping-client

run-omninames: omninames
	docker run -itd --net=corba --name nameservice omninames

run-omni-ping-server: omni-ping-server
	docker run -it --rm --net=corba omni-ping-server

run-omni-ping-client: omni-ping-client
	docker run -it --rm --net=corba omni-ping-client

run-tao-ping-server: tao-ping-server
	docker run -it --rm --net=corba tao-ping-server

run-tao-ping-client: tao-ping-client
	docker run -it --rm --net=corba tao-ping-client
