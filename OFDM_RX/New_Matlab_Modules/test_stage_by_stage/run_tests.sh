#!/usr/bin/env bash
# run_tests.sh - headless runner for the MATLAB test suite
set -e
BASEDIR="$(cd "$(dirname "$0")" && pwd)"
MATLAB_CMD="matlab"

echo "Running tests from ${BASEDIR}"

# Run MATLAB headless; adjust MATLAB_CMD if necessary (e.g., matlabR2020a)
"${MATLAB_CMD}" -nodisplay -nosplash -r "try, cd('${BASEDIR}'); run_all_tests; catch e, disp(getReport(e)); exit(1); end; exit(0);"
