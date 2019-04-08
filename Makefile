IMAGE := pisa/pisa-osirrc2019

image:
	docker build -t $(IMAGE) .

push-image:
	docker push $(IMAGE)


.PHONY: image push-image 
