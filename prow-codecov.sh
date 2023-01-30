#!/bin/bash
set -euo pipefail

# https://github.com/kubernetes/test-infra/blob/master/prow/jobs.md
# https://docs.codecov.com/docs/codecov-uploader

JOB_TYPE=${JOB_TYPE:-local}
REF_FLAGS=""

if [[ "${JOB_TYPE}" == "presubmit" ]]; then
  REF_FLAGS="-P ${PULL_NUMBER} -C ${PULL_PULL_SHA}"
fi

if [[ $CODECOV_TOKEN ]]; then
  curl -Os https://uploader.codecov.io/latest/linux/codecov
  chmod +x codecov
  ./codecov -t ${CODECOV_TOKEN} -r "openshift/hac-core" ${REF_FLAGS} --dir ./frontend/coverage
fi
