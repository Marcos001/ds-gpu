.PHONY : help

#---------- # 
# VARIABLEs #
#---------- #

# change to your project and data folder
APP = "/home/marcos/projects/"
DATA = "/home/marcos/data/"

# config docker image and container
IMAGE = "ds-gpu:0.0.2"
CONTAINER = "ds-gpu-container"
DSHOME = "/home/ds/app/"
DSDATA = "/media/ds/data/"

MPORT = 8000 # machine port, previous 8888
CPORT = 8890 # container port, previous 8888

#--------- # 
# ACTIONS  #
#--------- #

build:
	@echo "Build image $(IMAGE)" 
	@docker build  --no-cache  --build-arg HOME=$(DSHOME) --force-rm -t $(IMAGE) .


clean:
	@docker stop $(CONTAINER)
	@docker rm $(CONTAINER)


up:
	@docker run --gpus all -d --name $(CONTAINER) \
	 -it -v $(APP):$(DSHOME) -v $(DATA):(DSDATA) $(IMAGE) bash


up-lab:
	@docker run --gpus all -d --name $(CONTAINER) \
	-p $(MPORT):$(CPORT) \
	-it -v $(APP):$(DSHOME) -v $(DATA):$(DSDATA) $(IMAGE) \
	jupyter-notebook --ip 0.0.0.0 --port=$(CPORT) --no-browser --allow-root


view-logs:
	@docker logs $(CONTAINER)
