# PISA OSIRRC Docker Image v0.0.1

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
  --repo pisa/pisa-osirrc2019  \
  --collection Robust04 \
  --topic topics/topics.robust04.txt \
  --output $(pwd)/output \
  --qrels $(pwd)/qrels/qrels.robust04.txt
```

TODO: Add custom args..

## Expected Results


### core17

BM25                                    | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2017 Common Core Track Topics](https://trec.nist.gov/data/core/core_nist.txt)| 0.2078 | 0.4260 | 0.3898 |

### core18

BM25                                    | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2018 Common Core Track Topics](https://trec.nist.gov/data/core/topics2018.txt)| 0.2384 | 0.3500 |  |

### cw09b

MAP                                     | BM25      |
:---------------------------------------|-----------|
[TREC 2010 Web Track: Topics 51-100](http://trec.nist.gov/data/web/10/wt2010-topics.xml)| 0    | 
[TREC 2011 Web Track: Topics 101-150](http://trec.nist.gov/data/web/11/full-topics.xml)| 0    | 
[TREC 2012 Web Track: Topics 151-200](http://trec.nist.gov/data/web/12/full-topics.xml)| 0    | 

### cw12b

MAP                                     | BM25      | 
:---------------------------------------|-----------|
[TREC 2013 Web Track: Topics 201-250](http://trec.nist.gov/data/web2013.html)| 0    | 
[TREC 2014 Web Track: Topics 251-300](http://trec.nist.gov/data/web2014.html)| 0    |

### gov2

MAP                                     | BM25      |
:---------------------------------------|-----------|
[TREC 2004 Terabyte Track: Topics 701-750](http://trec.nist.gov/data/terabyte04.html)| 0    | 
[TREC 2005 Terabyte Track: Topics 751-800](http://trec.nist.gov/data/terabyte05.html)| 0    | 
[TREC 2006 Terabyte Track: Topics 801-850](http://trec.nist.gov/data/terabyte06.html)| 0    | 

### robust04

BM25                                    | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2004 Robust Track Topics](http://trec.nist.gov/data/robust/04.testset.gz)| 0.2537    | 0.3120    | |

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

