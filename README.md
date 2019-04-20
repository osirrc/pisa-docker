# Docker image in jig format for PISA

[![Build Status](https://travis-ci.com/osirrc2019/pisa-docker.svg?branch=master)](https://travis-ci.com/osirrc2019/pisa-docker)

PISA Docker image for the SIGIR OSIRRC 2019 Open Source Challenge.

## Running
Use the commands below to run the image from the [jig](https://github.com/osirrc2019/jig) directory, updating the corpus details as appropriate.

### Pull from DockerHub
```
docker pull pisa/pisa-osirrc2019
```

### Prepare
```
python run.py prepare 
  --repo pisa/pisa-osirrc2019 \
  --tag latest \
  --collections Robust04=/data/collections/disk45
```

### Search
```
python run.py search \
  --repo pisa/pisa-osirrc2019 
  --collection Robust04 
  --topic topics.robust04.301-450.601-700.txt 
  --output $(pwd)/output  
  --qrels $(pwd)/qrels/qrels.robust2004.txt
```
