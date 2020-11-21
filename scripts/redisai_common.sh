#!/bin/bash

# Redis Database
DATABASE_HOST=${DATABASE_HOST:-"127.0.0.1"}
MODELSERVER_HOST=${MODELSERVER_HOST:-"127.0.0.1"}
DATABASE_PORT=${DATABASE_PORT:-6379}
TRITON_PORT=${TRITON_PORT:-8001}

DEVICE=${DEVICE:-"cpu"}
VISION_MODEL_NAME=${VISION_MODEL_NAME:-"mobilenet_v1_100_224_${DEVICE}"}

MIN_BATCHSIZE=${MIN_BATCHSIZE:-0}
BATCHSIZE_STEP=${BATCHSIZE_STEP:-10}
MAX_BATCHSIZE=${MAX_BATCHSIZE:-50}

MIN_TENSOR_BATCHSIZE=${MIN_TENSOR_BATCHSIZE:-0}
TENSOR_BATCHSIZE_STEP=${TENSOR_BATCHSIZE_STEP:-10}
MAX_TENSOR_BATCHSIZE=${MAX_TENSOR_BATCHSIZE:-50}

DATA_SEED=${DATA_SEED:-12345}
MODEL_NAME=${MODEL_NAME:-"financialNet"}
MODEL_NAME_NOREFERENCE=${MODEL_NAME_NOREFERENCE:-"financialNet_NoReference"}
SETUP_MODEL=${SETUP_MODEL:-"true"}
REDIS_PIPELINE_SIZE=${REDIS_PIPELINE_SIZE:-100}
DEBUG=${DEBUG:-0}
DATA_FILE_NAME=${DATA_FILE_NAME:-aibench_generate_data-creditcard-fraud.dat}
PRINT_RESPONSES=${PRINT_RESPONSES:-false}
SLEEP_BETWEEN_RUNS=${SLEEP_BETWEEN_RUNS:-30}

# Rate limit? if greater than 0 rate is limited.
RATE_LIMIT=${RATE_LIMIT:-0}

# output name
OUTPUT_NAME_SUFIX=${OUTPUT_NAME_SUFIX:-""}

# Data folder
BULK_DATA_DIR=${BULK_DATA_DIR:-"/tmp/bulk_data"}

# ensure dir exists
mkdir -p ${BULK_DATA_DIR}

# Full path to data file
DATA_FILE=${DATA_FILE:-${BULK_DATA_DIR}/${DATA_FILE_NAME}}

INPUT_VISION_VAL_DIR=${INPUT_VISION_VAL_DIR:-datasets/vision/coco-2017-val/cropped-val2017/.}
OUTPUT_VISION_FILE_NAME=${OUTPUT_VISION_FILE_NAME:-${BULK_DATA_DIR}/vision_tensors.out}
NUM_VISION_INFERENCES=${NUM_VISION_INFERENCES:-50000}
VISION_QUERIES_BURN_IN=${VISION_QUERIES_BURN_IN:-100}
VISION_IMAGE_REUSE_FACTOR=${VISION_IMAGE_REUSE_FACTOR:-10}

# How many concurrent workers - match num of cores, or default to 8
NUM_WORKERS=${NUM_WORKERS:-$(grep -c ^processor /proc/cpuinfo 2>/dev/null || echo 16)}
# How many INFERENCES to Generate/Run
NUM_INFERENCES=${NUM_INFERENCES:-1000000}
# How many inferences to discard data at the beginning ( make the model server hot )
QUERIES_BURN_IN=${QUERIES_BURN_IN:-10000}

MIN_CLIENTS=${MIN_CLIENTS:-0}
CLIENTS_STEP=${CLIENTS_STEP:-10}
MAX_CLIENTS=${MAX_CLIENTS:-50}
RUNS_PER_VARIATION=${RUNS_PER_VARIATION:-3}



