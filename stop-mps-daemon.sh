#! /bin/bash

# terminate the MPS daemon
if [ "$CUDA_MPS_USER" ]; then
  # terminate the MPS daemon in single user mode
  export CUDA_MPS_PIPE_DIRECTORY=/tmp/$CUDA_MPS_USER/nvidia-mps-control
  export CUDA_MPS_LOG_DIRECTORY=/tmp/$CUDA_MPS_USER/nvidia-mps-logs
  echo quit -t 5 | /usr/bin/sudo -u $CUDA_MPS_USER nvidia-cuda-mps-control
else
  # terminate the MPS daemon in multi user mode
  unset CUDA_MPS_PIPE_DIRECTORY
  unset CUDA_MPS_LOG_DIRECTORY
  echo quit -t 5 | /usr/bin/sudo nvidia-cuda-mps-control
fi

# reset the device(s) to default mode
if [ "$CUDA_VISIBLE_DEVICES" ]; then
  /usr/bin/sudo nvidia-smi -i $CUDA_VISIBLE_DEVICES -c DEFAULT
else
  /usr/bin/sudo nvidia-smi -c DEFAULT
fi
