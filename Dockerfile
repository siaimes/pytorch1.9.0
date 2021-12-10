FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel AS builder

WORKDIR /

RUN apt-get update && apt-get install -y curl zip

RUN curl https://dl.freefontsfamily.com/download/Times-New-Roman-Font/ -o Times-New-roman.zip

RUN unzip Times-New-roman.zip

RUN mkdir Times-New-Roman

COPY ["Times New Roman/*", "/Times-New-Roman"]

FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel

RUN conda install -y faiss-gpu scikit-learn pandas flake8 yapf isort yacs gdown future -c conda-forge

RUN pip install opencv-python tb-nightly matplotlib pyro-ppl

RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip

COPY --from=builder /Times-New-Roman/* /opt/conda/lib/python3.7/site-packages/matplotlib/mpl-data/fonts/ttf/
