FROM debian:latest

RUN apt update && apt install -y libboost-all-dev libusb-1.0-0-dev doxygen python3-docutils python3-mako python3-numpy python3-requests python3-ruamel.yaml python3-setuptools git cmake build-essential

RUN git clone https://github.com/EttusResearch/uhd.git /uhd

RUN cd /uhd \ 
&& git checkout v4.3.0.0 \
&& cd /uhd/host \ 
&& mkdir build \
&& cd /uhd/host/build \ 
&& cmake ../ \
&& make -j $(nproc) \
&& make test \
&& make install \
&& ldconfig \
&& uhd_images_downloader

RUN apt install -y cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev git

RUN git clone --depth 1 --branch release_23_5 https://github.com/srsran/srsRAN_Project.git /srsran

RUN cd /srsran \
&& mkdir build \
&& cd /srsran/build \
&& cmake .. \ 
&& make 

COPY srsran/gnb_band71.conf /srsran/build/apps/gnb/

