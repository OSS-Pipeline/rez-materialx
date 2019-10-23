#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
BUILD_PATH=$2
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
MATERIALX_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "================="
echo -e "=== CONFIGURE ==="
echo -e "================="
echo -e "\n"

echo -e "[CONFIGURE][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[CONFIGURE][ARGS] BUILD PATH: ${BUILD_PATH}"
echo -e "[CONFIGURE][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[CONFIGURE][ARGS] MATERIALX VERSION: ${MATERIALX_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${BUILD_PATH} || -z ${INSTALL_PATH} || -z ${MATERIALX_VERSION} ]]; then
    echo -e "\n"
    echo -e "[CONFIGURE][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We run the configuration script of MaterialX.
echo -e "\n"
echo -e "[CONFIGURE] Running the configuration script from MaterialX-${MATERIALX_VERSION}..."
echo -e "\n"

mkdir -p ${BUILD_PATH}
cd ${BUILD_PATH}

cmake \
    ${BUILD_PATH}/.. \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DCMAKE_POLICY_DEFAULT_CMP0072=NEW \
    -DMATERIALX_BUILD_DOCS=OFF \
    -DMATERIALX_BUILD_OIIO=OFF \
    -DMATERIALX_BUILD_PYTHON=ON \
    -DMATERIALX_BUILD_VIEWER=OFF \
    -DMATERIALX_INSTALL_PYTHON=ON \
    -DMATERIALX_PYTHON_LTO=ON \
    -DMATERIALX_TEST_RENDER=ON \
    -DMATERIALX_WARNINGS_AS_ERRORS=ON \
    -DMATERIALX_PYTHON_EXECUTABLE=${REZ_PYTHON_ROOT}/bin/python \
    -DMATERIALX_PYTHON_VERSION=${REZ_PYTHON_MAJOR_VERSION}.${REZ_PYTHON_MINOR_VERSION} \
    -DMATERIALX_OSLC_EXECUTABLE=${REZ_OSL_ROOT}/bin/oslc \
    -DMATERIALX_TESTRENDER_EXECUTABLE=${REZ_OSL_ROOT}/bin/testrender \
    -DMATERIALX_OSL_INCLUDE_PATH=${REZ_OSL_ROOT}/shaders \

echo -e "\n"
echo -e "[CONFIGURE] Finished configuring MaterialX-${MATERIALX_VERSION}!"
echo -e "\n"
