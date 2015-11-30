images: omninames c-orbit2-ping-server c-orbit2-ping-client cpp-tao-ping-server cpp-tao-ping-client cs-iiopnet-ping-server cs-iiopnet-ping-client java-jacorb-ping-server java-jacorb-ping-client nim-tao-ping-client python-omniorb-ping-server python-omniorb-ping-client

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

hy-omniorb-ping-server:
	docker build -f Dockerfile-hy-omniorb-ping-server -t hy-omniorb-ping-server .

hy-omniorb-ping-client:
	docker build -f Dockerfile-hy-omniorb-ping-client -t hy-omniorb-ping-client .

java-jacorb-ping-server:
	docker build -f Dockerfile-java-jacorb-ping-server -t java-jacorb-ping-server .

java-jacorb-ping-client:
	docker build -f Dockerfile-java-jacorb-ping-client -t java-jacorb-ping-client .

jython-jacorb-ping-server:
	docker build -f Dockerfile-jython-jacorb-ping-server -t jython-jacorb-ping-server .

jython-jacorb-ping-client:
	docker build -f Dockerfile-jython-jacorb-ping-client -t jython-jacorb-ping-client .

nim-orbit2-ping-client:
	docker build -f Dockerfile-nim-orbit2-ping-client -t nim-orbit2-ping-client .

nim-tao-ping-client:
	docker build -f Dockerfile-nim-tao-ping-client -t nim-tao-ping-client .

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

run-hy-omniorb-ping-server: hy-omniorb-ping-server
	docker run -it --rm --net=corba hy-omniorb-ping-server

run-hy-omniorb-ping-client: hy-omniorb-ping-client
	docker run -it --rm --net=corba hy-omniorb-ping-client

run-java-jacorb-ping-server: java-jacorb-ping-server
	docker run -it --rm --net=corba java-jacorb-ping-server

run-java-jacorb-ping-client: java-jacorb-ping-client
	docker run -it --rm --net=corba java-jacorb-ping-client

run-jython-jacorb-ping-server: jython-jacorb-ping-server
	docker run -it --rm --net=corba jython-jacorb-ping-server

run-jython-jacorb-ping-client: jython-jacorb-ping-client
	docker run -it --rm --net=corba jython-jacorb-ping-client

run-nim-orbit2-ping-client: nim-orbit2-ping-client
	docker run -it --rm --net=corba nim-orbit2-ping-client

run-nim-tao-ping-client: nim-tao-ping-client
	docker run -it --rm --net=corba nim-tao-ping-client

run-omninames: omninames
	docker run -itd --net=corba --name nameservice omninames

run-python-omniorb-ping-server: python-omniorb-ping-server
	docker run -it --rm --net=corba python-omniorb-ping-server

run-python-omniorb-ping-client: python-omniorb-ping-client
	docker run -it --rm --net=corba python-omniorb-ping-client
