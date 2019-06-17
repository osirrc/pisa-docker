# OSIRRC Docker Image for PISA

[![Build Status](https://travis-ci.com/osirrc/pisa-docker.svg?branch=master)](https://travis-ci.com/osirrc/pisa-docker)
[![DOI](https://zenodo.org/badge/179735565.svg)](https://zenodo.org/badge/latestdoi/179735565)

[Antonio Mallia](https://github.com/amallia), [Michał Siedlaczek](https://github.com/elshize), [Joel Mackenzie](https://github.com/JMMackenzie), and [Torsten Suel](https://github.com/torstensuel)

This is the docker image for the [PISA: Performant Indexes and Search for Academia](https://github.com/pisa-engine/pisa) (v0.6.3) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on Docker Hub has been tested with the jig at commit b00aab4 (6/6/2019).

+ Supported test collections: `robust04`, `core17`, `core18` (newswire); `gov2`, `cw09b`, `cw12b` (web)
+ Supported hooks: `init`, `index`, `search`

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python run.py prepare 
  --repo osirrc2019/pisa \
  --tag v0.1.1 \
  --collections Robust04=/data/collections/disk45
```

The following `jig` command can be used to perform a retrieval run on the collection with the `robust04` test collection.

```
python run.py search \
  --repo osirrc2019/pisa \
  --tag v0.1.1 \
  --collection Robust04 \
  --topic topics/topics.robust04.txt \
  --output $(pwd)/output \
  --qrels $(pwd)/qrels/qrels.robust04.txt
```
## Retrieval Methods

The PISA image supports the following retrieval methods:

+ **BM25**: k1=0.9, b=0.4 (Robertson et al., 1995)

## Runtime Options
The default search system can be changed. For example, we allow a few different index compression and search algorithms
to be used. These options are supplied using `--opts [option]=[value]`

### Index
- `stemmer` can be either `krovetz` or `porter2`, default is `porter2`. 
- `compressor` can be `opt` (Partitioned Elias Fano), `block_interpolative` (Interpolative), `block_simdbp` (SIMD-BP128), or `block_optpfor` (OPT-PFor Delta), `block_simdbp` is the default. Multiple compressors can be passed using a comma delimiter, eg: `--opts compressor="block_simdbp,opt"`. 
- `block_type` can be either `fixed` or `variable`, default is `variable`. If `fixed` is used, `block_size` must also be supplied, where `block_size` is a positive integer. 

### Search
- `stemmer` is the same as above, and is used for stemming queries.
- `compressor` is the same as above, and should match the given `compressor` used during indexing. However, only one single `compressor` can be provided at a time.
- `algorithm` can be `wand`, `maxscore`, or `block_max_wand`. `block_max_wand` is the default.
- `block_type` is the same as above, and should match the given `block_type` used during indexing. For search, `block_size` is not required.

## Supported collections

For indexing, the corpus name defines the indexing configuration. The following values are supported:

- robust04 - TREC Disks 4&5. 
- core17 - the New York Times corpus. 
- core18 - the TREC Washington Post (WAPO) corpus. 
- gov2 - the TREC GOV2 corpus.
- cw09b - the TREC ClueWeb09 corpus.
- cw12b - the TREC ClueWeb12 corpus.

## A note on default configuration
As discussed above, the default configuration is as follows:
 - Porter 2 Stemming
 - SIMD-BP128 compression
 - Variable-sized blocks and Block-Max WAND, leading to the "Variable BMW" algorithm

Since the Variable-sized blocks depend on a parameter, lambda, we have searched for
the correct value of lambda offline, and hardcoded these values into the `lamb()`
method within the `index` call. We found values of lambda that result in a mean
block size of 40 elements per block, with a possible error rate of plus/minus 0.5
elements. Please note that these lambda values only apply to the default parsing 
and indexing setup, and would need to be searched again if settings are changed
(for example, if a different stemmer was used).

## Expected Results

### robust04

BM25                                    | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2004 Robust Track Topics](http://trec.nist.gov/data/robust/04.testset.gz)| 0.2537    | 0.3120    | |

### core17

BM25                                    | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2017 Common Core Track Topics](https://trec.nist.gov/data/core/core_nist.txt)| 0.2078 | 0.4260 | 0.3898 |

### core18

BM25                                    | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2018 Common Core Track Topics](https://trec.nist.gov/data/core/topics2018.txt)| 0.2384 | 0.3500 |  |

### cw09b

BM25                                     | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2009 Web Track: Topics 1-50](https://trec.nist.gov/data/web/09/wt09.topics.full.xml)| 0    | 
[TREC 2010 Web Track: Topics 51-100](http://trec.nist.gov/data/web/10/wt2010-topics.xml)| 0    | 
[TREC 2011 Web Track: Topics 101-150](http://trec.nist.gov/data/web/11/full-topics.xml)| 0    | 
[TREC 2012 Web Track: Topics 151-200](http://trec.nist.gov/data/web/12/full-topics.xml)| 0    | 

### cw12b

BM25                                     | MAP       | P@30      | NDCG@20 |
:---------------------------------------|-----------|-----------|---------|
[TREC 2013 Web Track: Topics 201-250](http://trec.nist.gov/data/web2013.html)| 0    | 
[TREC 2014 Web Track: Topics 251-300](http://trec.nist.gov/data/web2014.html)| 0    |

### gov2

BM25                                     |  MAP       | P@30      | NDCG@20 |
:---------------------------------------|------------|-----------|---------|
[TREC 2004 Terabyte Track: Topics 701-750](http://trec.nist.gov/data/terabyte04.html)| 0    | 
[TREC 2005 Terabyte Track: Topics 751-800](http://trec.nist.gov/data/terabyte05.html)| 0    | 
[TREC 2006 Terabyte Track: Topics 801-850](http://trec.nist.gov/data/terabyte06.html)| 0    | 


## Implementation

The following is a quick breakdown of what happens in each of the scripts in this repo.

### Dockerfile

The `Dockerfile` derives from the official [PISA docker image](https://github.com/pisa-engine/docker). Additionally, it installs dependencies (python3, etc.), copies scripts to the root dir, and sets the working dir to /work.


### init

The `init` [script](init) is empty since all the initialization is executed during Docker image building. 

### index

The `index` [script](index) reads a JSON string (see [here](https://github.com/osirrc/jig#index)) containing at least one collection to index (including the name, path, and format).
The collection is indexed and placed in a directory, with the same name as the collection, in the working dir (i.e., `/work/robust04`).
At this point, `jig` takes a snapshot and the indexed collections are persisted for the `search` hook.

### search

The `search` [script](search) reads a JSON string (see [here](https://github.com/osirrc/jig#search)) containing the collection name (to map back to the index directory from the `index` hook) and topic path, among other options.
The retrieval run is performed (using additional `--opts` params, see above) and output is placed in `/output` for the `jig` to evaluate using `trec_eval`.


## Reviews

+ Documentation reviewed at commit [`8f88235`](https://github.com/osirrc/pisa-docker/commit/21d04fb483158e17892ed1515414870b48f88235) (2019-06-17) by [Ryan Clancy](https://github.com/r-clancy/)
