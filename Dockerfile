# Dependencies
FROM tensorflow/tensorflow:1.12.3-gpu-py3
RUN apt-get update && apt-get install -y --no-install-recommends libsm6 libxext6 libxrender-dev libgl1-mesa-glx
RUN pip install h5py easydict scipy opencv-python pyyaml toposort vtk

# Build context
WORKDIR /DeepV2D
COPY deepv2d deepv2d 
COPY models/nyu.ckpt* models/
COPY data/demos/nyu_0* data/demos/nyu_0 
COPY demos demos
COPY cfgs cfgs

# Build 
RUN cd deepv2d/special_ops && bash make.sh && cd ../..

# Run
# RUN python demos/demo_v2d.py --model=models/nyu.ckpt --sequence=data/demos/nyu_0
