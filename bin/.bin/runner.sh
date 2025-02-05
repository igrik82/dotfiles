#!/usr/bin/env bash
INFULLFILENAME=$1
DIRECTORY=$2
SILENT=$3
OUTFILENAME=$4

# Parse filename and extension
INFILENAME=${INFULLFILENAME%.*}
INFILEEXT=${INFULLFILENAME##*.}

# If no directory is specified, use current directory
if [ -z "${DIRECTORY}" ]; then
  DIRECTORY="."
fi

# Check extension and run corresponding script
case "$INFILEEXT" in
  "cpp")
    # Get project name
    OUTFILENAME=$(grep -E "^project" "${DIRECTORY}"/CMakeLists.txt | cut -d'(' -f2 | cut -d')' -f1)

    if [ "${SILENT}" == "true" ]; then
      cmake -S "${DIRECTORY}" -B "${DIRECTORY}"/build >/dev/null 2>&1
      if [ $? -eq 0 ]; then
        cmake --build "${DIRECTORY}"/build >/dev/null 2>&1
      fi
    else
      cmake -S "${DIRECTORY}" -B "${DIRECTORY}"/build
      cmake --build "${DIRECTORY}"/build -j "$(nproc)"
      if [ $? -eq 0 ]; then
        "${DIRECTORY}"/build/Debug/"${OUTFILENAME}"
      fi
    fi
    if [ $? -eq 0 ]; then
      exit 0
    else
      exit 1
    fi
    ;;

  "py")
    python "${DIRECTORY}"/"${INFILENAME}".py
    ;;

esac
