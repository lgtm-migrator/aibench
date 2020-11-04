#!/bin/bash
#Exit immediately if a command exits with a non-zero status.
set -e

# Ensure generator is available
EXE_FILE_NAME=${EXE_FILE_NAME:-$(which aibench_run_inference_redisai_vision)}
if [[ -z "${EXE_FILE_NAME}" ]]; then
  echo "aibench_run_inference_redisai_vision not available. It is not specified explicitly and not found in \$PATH"
  exit 1
fi

# Load parameters - common
EXE_DIR=${EXE_DIR:-$(dirname $0)}
source ${EXE_DIR}/redisai_common.sh

# Ensure data file is in place
if [ ! -f ${OUTPUT_VISION_FILE_NAME} ]; then
  echo "Cannot find data file ${OUTPUT_VISION_FILE_NAME}"
  exit 1
fi

# we overload the NUM_WORKERS here for the official benchmark
for NUM_WORKERS in $(seq ${MIN_CLIENTS} ${CLIENTS_STEP} ${MAX_CLIENTS}); do
  if [ $NUM_WORKERS == 0 ]; then
    NUM_WORKERS=1
  fi
  for RUN in $(seq 1 ${RUNS_PER_VARIATION}); do
    FILENAME_SUFFIX=redisai_${OUTPUT_NAME_SUFIX}_${DEVICE}_run_${RUN}_workers_${NUM_WORKERS}_rate_${RATE_LIMIT}.txt
    echo "Benchmarking inference performance with ${NUM_WORKERS} workers. Model name ${VISION_MODEL_NAME}"
    echo "\t\tSaving files with file suffix: ${FILENAME_SUFFIX}"
    # benchmark inference performance
    # make sure you're on the root project folder

    ${EXE_FILE_NAME} \
      --file=${OUTPUT_VISION_FILE_NAME} \
      -model=${VISION_MODEL_NAME} \
      -debug=${DEBUG} \
      -workers=${NUM_WORKERS} \
      -batch-size=${TENSOR_BATCHSIZE} \
      -burn-in=${VISION_QUERIES_BURN_IN} -max-queries=${NUM_VISION_INFERENCES} \
      -print-interval=0 -reporting-period=1000ms \
      -host=${DATABASE_HOST} \
      -port=${DATABASE_PORT} \
      2>&1 | tee ~/RAW_${FILENAME_SUFFIX}

    echo "Sleeping: $SLEEP_BETWEEN_RUNS"
    sleep ${SLEEP_BETWEEN_RUNS}
  done
done
