#! /bin/bash

# set the device(s) to exclusive mode
if [ "$CUDA_VISIBLE_DEVICES" ]; then
  /usr/bin/sudo nvidia-smi -i $CUDA_VISIBLE_DEVICES -c EXCLUSIVE_PROCESS
else
  /usr/bin/sudo nvidia-smi -c EXCLUSIVE_PROCESS
fi

# start the MPS daemon
if [ "$CUDA_MPS_USER" ]; then
  # start the MPS daemon in single user mode
  export CUDA_MPS_PIPE_DIRECTORY=/tmp/$CUDA_MPS_USER/nvidia-mps-control
  export CUDA_MPS_LOG_DIRECTORY=/tmp/$CUDA_MPS_USER/nvidia-mps-logs
  mkdir -p $CUDA_MPS_PIPE_DIRECTORY $CUDA_MPS_LOG_DIRECTORY
  echo CUDA_MPS_PIPE_DIRECTORY=$CUDA_MPS_PIPE_DIRECTORY
  echo CUDA_MPS_LOG_DIRECTORY=$CUDA_MPS_LOG_DIRECTORY
  /usr/bin/sudo -u $CUDA_MPS_USER nvidia-cuda-mps-control -d
else
  # start the MPS daemon in multi user mode
  unset CUDA_MPS_PIPE_DIRECTORY
  unset CUDA_MPS_LOG_DIRECTORY
  /usr/bin/sudo nvidia-cuda-mps-control -d
fi
