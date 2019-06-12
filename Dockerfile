FROM gcc:8.3

COPY setup.sh setup.sh
RUN bash setup.sh
ENV PATH="/usr/bin/cmake/bin:${PATH}"

COPY init init
COPY index index
COPY search search

WORKDIR /work
