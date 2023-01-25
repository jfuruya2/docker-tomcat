version=8.5.85

image:
	docker build -t alpine-tomcat:$(version)-jdk8 .
	docker tag alpine-tomcat:$(version)-jdk8 alpine-tomcat:latest