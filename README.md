# PISA OSIRRC Docker Image

[![Build Status](https://travis-ci.com/osirrc/pisa-docker.svg?branch=master)](https://travis-ci.com/osirrc/pisa-docker)

[Antonio Mallia](https://github.com/amallia), [Michał Siedlaczek](https://github.com/elshize), [Joel Mackenzie](https://github.com/JMMackenzie), [Torsten Suel](https://github.com/torstensuel)

This is the docker image for the [PISA: Performant Indexes and Search for Academia](https://github.com/pisa-engine/pisa) (v0.6.3) conforming to the OSIRRC jig for the Open-Source IR Replicability Challenge (OSIRRC 2019) at SIGIR 2019. This image is available on Docker Hub has been tested with the jig at commit b00aab4 (6/6/2019).

+ Supported test collections: `core17`, `core18`, `cw09b`, `cw12b`, `gov2`, `robust04`
+ Supported hooks: `init`, `index`, `search`

## Running
Use the commands below to run the image from the [jig](https://github.com/osirrc/jig) directory, updating the corpus details as appropriate.

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
