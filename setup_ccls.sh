#!/usr/bin/bash
CURRENT_DIR="$( dirname ${BASH_SOURCE[0]} )"
. "$CURRENT_DIR/common.sh"

echo "> Install dependencies"
sudo apt-get install cmake clang libclang-dev llvm rapidjson-dev

pushd "$(get_source_dir)" > /dev/null

if [[ -d ccls ]]; then
    read -p "> ccls folder already exists, do you want to skip the clone? [N/y] " -n 1 -r
    if [[ $REPLY != y ]] || [[ -z $REPLY ]]; then
	echo "> Skip clone."
    else
	backup_folder ccls
	git clone --depth=1 --recursive https://github.com/MaskRay/ccls
    fi
fi

cd ccls

cmake -H. -BRelease -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=$(llvm-config --prefix) \
    -DLLVM_INCLUDE_DIR=$(llvm-config --includedir)

cd Release/
make -j4

popd > /dev/null

echo "> Note cmake error: `fatal: No names found, cannot describe anything.` can be ignored."
echo "> Done"
