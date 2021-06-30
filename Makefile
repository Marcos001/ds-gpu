.PHONY : help

#---------- # 
# VARIABLEs #
#---------- #

# change to your project and data folder
APP = "/home/marcos/projects/"
DATA = "/home/marcos/data/"

# config docker image and container
IMAGE = "ds-gpu:0.0.1"
CONTAINER = "ds-gpu-container"
DSHOME = "/home/ds/app/"
DSDATA = "/media/ds/data/"

HPORT = 8001
CPORT = 8888

#--------- # 
# ACTIONS  #
#--------- #

build-run:
	@echo "Build image $(IMAGE)" 
	@docker build  --no-cache  --build-arg HOME=$(DSHOME) --force-rm -t $(IMAGE) .

build-dc:
	@echo "Build image $(IMAGE)" 
	@docker build --env-file neo.env  --no-cache --force-rm -t $(IMAGE) .


clean:
	@docker stop $(CONTAINER)
	@docker rm $(CONTAINER)


up:
	@docker run --gpus all -d --name $(CONTAINER) \
	 -it -v $(APP):$(DSHOME) -v $(DATA):$(DSDATA) $(IMAGE) bash


up-lab:
	@docker run --gpus all -d --name $(CONTAINER) \
	-p "0.0.0.0:$(HPORT):$(CPORT)" \
	-it -v $(APP):$(DSHOME) -v $(DATA):$(DSDATA) $(IMAGE) \
	jupyter-notebook --ip 0.0.0.0 --port=$(CPORT) --no-browser --allow-root


view-logs:
	@docker logs $(CONTAINER)
