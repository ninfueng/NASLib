FROM nvcr.io/nvidia/pytorch:26.08-py3

ENV LANGUAGE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

# Support: A100, RTX 4090, Orin, A6000, PRO 6000 Blackwell, RTX 5070 Ti others
ENV TORCH_CUDA_ARCH_LIST="8.0 8.6 8.7 8.9 12.0+PTX"
ENV DISPLAY=0

# TensorBoard, Jupyter
EXPOSE 6006 8888

RUN apt update && \
    apt upgrade -y && \
    apt install --no-install-recommends -y \
        wget \
        curl \
        build-essential \
        ninja-build \
        tar \
        zip \
        unzip \
        git \
        htop \
        vim \
        tmux \
        ffmpeg \
        libsm6 \
        libxext6 \
        python3-tk \
        && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache \
    kornia==0.6.12 \
    SharedArray \
    av2 \
    pyquaternion \
    nuscenes-devkit==1.0.5 \
    tensorboardX \
    easydict \
    spconv-cu126 \
    fvcore \
    pytorch-msssim \
    transforms3d \
    ngboost \
    pybnn \
    pyro-ppl \
    GraKeL \
    tornado \
    tensorwatch \
    seaborn \
    && \
    pip3 install --no-cache --no-build-isolation torch-scatter && \
    pip3 install --no-cache wandb scikit-image && \
    pip3 install --no-cache numpy==1.26.4

WORKDIR /workspace
ENTRYPOINT ["/bin/bash"]
