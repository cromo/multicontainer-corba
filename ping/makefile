images: omninames c-orbit2-ping-server c-orbit2-ping-client cpp-tao-ping-server cpp-tao-ping-client cs-iiopnet-ping-server cs-iiopnet-ping-client java-jacorb-ping-server java-jacorb-ping-client python-omniorb-ping-server python-omniorb-ping-client

c-orbit2-ping-server:
	docker build -f Dockerfile-c-orbit2-ping-server -t c-orbit2-ping-server .

c-orbit2-ping-client:
	docker build -f Dockerfile-c-orbit2-ping-client -t c-orbit2-ping-client .

cpp-tao-ping-server:
	docker build -f Dockerfile-cpp-tao-ping-server -t cpp-tao-ping-server .

cpp-tao-ping-client:
	docker build -f Dockerfile-cpp-tao-ping-client -t cpp-tao-ping-client .

cs-iiopnet-ping-server:
	docker build -f Dockerfile-cs-iiopnet-ping-server -t cs-iiopnet-ping-server .

cs-iiopnet-ping-client:
	docker build -f Dockerfile-cs-iiopnet-ping-client -t cs-iiopnet-ping-client .

java-jacorb-ping-server:
	docker build -f Dockerfile-java-jacorb-ping-server -t java-jacorb-ping-server .

java-jacorb-ping-client:
	docker build -f Dockerfile-java-jacorb-ping-client -t java-jacorb-ping-client .

omninames:
	docker build -f Dockerfile-omninames -t omninames .

python-omniorb-ping-server:
	docker build -f Dockerfile-python-omniorb-ping-server -t python-omniorb-ping-server .

python-omniorb-ping-client:
	docker build -f Dockerfile-python-omniorb-ping-client -t python-omniorb-ping-client .

run-c-orbit2-ping-server: c-orbit2-ping-server
	docker run -it --rm --net=corba c-orbit2-ping-server

run-c-orbit2-ping-client: c-orbit2-ping-client
	docker run -it --rm --net=corba c-orbit2-ping-client

run-cpp-tao-ping-server: cpp-tao-ping-server
	docker run -it --rm --net=corba cpp-tao-ping-server

run-cpp-tao-ping-client: cpp-tao-ping-client
	docker run -it --rm --net=corba cpp-tao-ping-client
run-cs-iiopnet-ping-server: cs-iiopnet-ping-server
	docker run -it --rm --net=corba cs-iiopnet-ping-server

run-cs-iiopnet-ping-client: cs-iiopnet-ping-client
	docker run -it --rm --net=corba cs-iiopnet-ping-client

run-java-jacorb-ping-server: java-jacorb-ping-server
	docker run -it --rm --net=corba java-jacorb-ping-server

run-java-jacorb-ping-client: java-jacorb-ping-client
	docker run -it --rm --net=corba java-jacorb-ping-client

run-omninames: omninames
	docker run -itd --net=corba --name nameservice omninames

run-python-omniorb-ping-server: python-omniorb-ping-server
	docker run -it --rm --net=corba python-omniorb-ping-server

run-python-omniorb-ping-client: python-omniorb-ping-client
	docker run -it --rm --net=corba python-omniorb-ping-client
