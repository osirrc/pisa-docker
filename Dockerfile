FROM pisa/pisa

COPY init init
COPY index index
COPY search search

WORKDIR /work

