# PISA OSIRRC Docker Image

[![Build Status](https://travis-ci.com/osirrc/pisa-docker.svg?branch=master)](https://travis-ci.com/osirrc/pisa-docker)

[Antonio Mallia](https://github.com/amallia), [Michał Siedlaczek](https://github.com/elshize), [Joel Mackenzie](https://github.com/JMMackenzie), [Torsten Suel](https://github.com/torstensuel)

This is the docker image for the [PISA: Performant Indexes and Search for Academia](https://github.com/pisa-engine/pisa) (v0.6.3) conforming to the OSIRRC jig for the Open-Source IR Replicability Challenge (OSIRRC 2019) at SIGIR 2019. This image is available on Docker Hub has been tested with the jig at commit b00aab4 (6/6/2019).

+ Supported test collections: `core17`, `core18`, `cw09b`, `cw12b`, `gov2`, `robust04`
+ Supported hooks: `init`, `index`, `search`

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare 
  --repo pisa/pisa-osirrc2019 \
  --collections Robust04=/data/collections/disk45
```

The following `jig` command can be used to perform a retrieval run on the collection with the `robust04` test collection.

```
python run.py search \
  --repo pisa/pisa-osirrc2019 
  --collection Robust04 
  --topic topics.robust04.301-450.601-700.txt 
  --output $(pwd)/output  
  --qrels $(pwd)/qrels/qrels.robust2004.txt
```

TODO: Add custom args..

## Expected Results

TODO: add expected AP, etc.

## Implementation

The following is a quick breakdown of what happens in each of the scripts in this repo.

### Dockerfile

The `Dockerfile` ...

### init

The `init` [script](init) is straightforward - it does ...

### index

The `index` [script](index) reads a JSON string (see [here](https://github.com/osirrc/jig#index)) containing at least one collection to index (including the name, path, and format).
The collection is indexed and placed in a directory, with the same name as the collection, in the working dir (i.e., `/work/robust04`).
At this point, `jig` takes a snapshot and the indexed collections are persisted for the `search` hook.

### search

The `search` [script](search) reads a JSON string (see [here](https://github.com/osirrc/jig#search)) containing the collection name (to map back to the index directory from the `index` hook) and topic path, among other options.
The retrieval run is performed (using additional `--opts` params, see above) and output is placed in `/output` for the `jig` to evaluate using `trec_eval`.


## Reviews

+ Documentation reviewed at commit [xxxxxxx](https://github.com/osirrc/pisa-docker/commit/xxxxx) (mm/dd/yyyy) by [foo](https://github.com/foo/)

