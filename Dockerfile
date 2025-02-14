FROM ubuntu:22.04

RUN apt-get clean && \
    apt-get update && \
    apt-get install  -y git \
                        gfortran \
			libblas-dev \
			liblapack-dev \
			cmake && \
    git clone https://github.com/openmopac/mopac.git && \
    cd mopac && \
    mkdir build && \
    cd build && \
    cmake .. -DTESTS=OFF &&\
    make && \
    rm -rf /mopac/src && \
    rm -rf /mopac/tests && \
    rm -rf /mopac/data && \
    rm -rf /mopac/build/CMakeFiles && \
    apt-get remove -y git \
                      gfortran \
                      cmake && \
    rm -rf /var/lib/apt/lists/*

ENV PATH="$PATH:/mopac/build"

COPY docker_entrypoint.sh /bin/docker_entrypoint.sh

RUN chmod +x /bin/docker_entrypoint.sh

ENTRYPOINT ["/bin/docker_entrypoint.sh"]
