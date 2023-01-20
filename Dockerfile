FROM ubuntu:latest

#Tymoteusz Maj
#Geoinformacja
#401370

# Install base utilities
RUN apt-get update && \
    apt-get install -y build-essential  && \
    apt-get install -y wget && \
    apt-get install ffmpeg libsm6 libxext6  -y && \
    apt-get install libgl1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get -y install wget

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm Miniconda3-latest-Linux-x86_64.sh

# Put conda in path so we can use conda activate
ENV CONDA_DIR /opt/conda
RUN echo "source activate base" > ~/.bashrc
ENV PATH $CONDA_DIR/bin:$PATH


RUN conda update -n base -c defaults conda \
    && conda install -c conda-forge --yes laspy \
    && conda install -c conda-forge --yes numpy \
    && conda install -c conda-forge --yes ezdxf \
    && conda install pip \
    && conda install -c anaconda --yes scipy \
    && python -m pip install open3d \
    && conda install -c conda-forge ifcopenshell \
    && conda update -n base -c defaults conda

COPY wall.py /.
COPY 231110AC-11-Smiley-West-04-07-2007.ifc /.
CMD ["python", "wall.py"]
