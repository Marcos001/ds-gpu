.PHONY : help

#---------- # 
# VARIABLEs #
#---------- #

# change to your project and data folder
APP = $(PWD)
DATA = $(PWD)

# config docker image and container
IMAGE = "ds-gpu:0.0.1"
CONTAINER = "ds-gpu-container"
DSHOME = "/home/ds/app/"
DSDATA = "/media/ds/data/"


#--------- # 
# ACTIONS  #
#--------- #

build:
	@echo "Build image $(IMAGE)" 
	@docker build  --no-cache --force-rm -t $(IMAGE) .


clean:
	@docker stop $(CONTAINER)
	@docker rm $(CONTAINER)


up:
	@docker run --gpus all -d --name $(CONTAINER) \
	 -it -v $(APP):$(DSHOME) -v $(DATA):(DSDATA) $(IMAGE) bash


up-lab:
	@docker run --gpus all -d --name $(CONTAINER) \
	-p 8888:8888 \
	-it -v $(APP):$(DSHOME) -v $(DATA):(DSDATA) $(IMAGE) \
	jupyter-notebook --ip 0.0.0.0 --no-browser --allow-root


view-logs:
	@docker logs $(CONTAINER)
