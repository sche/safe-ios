set -ex
rsync -r ${SCRIPT_INPUT_FILE_0}/ ${SCRIPT_OUTPUT_FILE_0}
rsync -r ${SCRIPT_INPUT_FILE_0}.dSYM/ ${SCRIPT_OUTPUT_FILE_0}.dSYM

