version=9.0.76
repository=191229699519.dkr.ecr.ap-northeast-1.amazonaws.com/alpine-tomcat
image=alpine-tomcat

image:
	aws ecr get-login-password \
		--region ap-northeast-1 | \
		docker login \
			--username AWS \
			--password-stdin \
			191229699519.dkr.ecr.ap-northeast-1.amazonaws.com
	docker build -t $(image):$(version)-jdk8 .
remote-image:
	make image
	docker tag $(image):$(version)-jdk8 $(repository):$(version)-jdk8
	docker push $(repository):$(version)-jdk8
	docker tag $(image):$(version)-jdk8 $(repository):latest
	docker push $(repository):latest
