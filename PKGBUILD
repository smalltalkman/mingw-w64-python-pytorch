# Maintainer: gym603 <gui_yuan_miao@163.com>

_realname=pytorch
pkgbase=mingw-w64-python-${_realname}
pkgname=("${MINGW_PACKAGE_PREFIX}-python-${_realname}")
pkgver=1.4.0
pkgrel=1
pkgdesc="Tensors and Dynamic neural networks in Python with strong GPU acceleration (mingw-w64)"
arch=('any')
url="https://pytorch.org/"
license=('BSD')
depends=()
makedepends=("git"
             "patch"
             "${MINGW_PACKAGE_PREFIX}-python"
             "${MINGW_PACKAGE_PREFIX}-python-setuptools"
             "${MINGW_PACKAGE_PREFIX}-python-yaml"
             "${MINGW_PACKAGE_PREFIX}-cmake"
             "make")
source=("${_realname}-${pkgver}::git+https://github.com/pytorch/pytorch.git#tag=v$pkgver"
        "0001-tools.patch"
        "0002-c10.patch"
        "0003-third_party-sleef.patch"
        "0004-caffe2.patch")
sha256sums=('SKIP'
            '01532ae4e86f36530f8058076d7b0666ab2f1bfc2c59f81da1ec82d38e815b74'
            'd90b4a55fe5a61a69a6aec78a2931ce65603b6b16e855801cd0136157492c161'
            '7f0a626f11846585244534d2e0ae5f550e78d8acba7300efd73f4fa5b6db20af'
            '480446509485b7e7c3fb6f4678ac1889eda7ba6b18c24d4a7c07fb19770c4def')

# Helper macros to help make tasks easier #
apply_patch_with_msg() {
  for _patch in "$@"
  do
    msg2 "Applying ${_patch}"
    patch -Nbp1 -i "${srcdir}/${_patch}"
  done
}

prepare() {
  # rm -rf "${srcdir}/${_realname}-${pkgver}.orig"
  # cp -rp "${srcdir}/${_realname}-${pkgver}" "${srcdir}/${_realname}-${pkgver}.orig"

  cd "${srcdir}/${_realname}-${pkgver}"

  git submodule update --init --recursive --force

  if [ ! -d "${srcdir}/${_realname}-${pkgver}.orig" ]; then
    cp -rp "${srcdir}/${_realname}-${pkgver}" "${srcdir}/${_realname}-${pkgver}.orig"
  fi

  apply_patch_with_msg \
    0001-tools.patch \
    0002-c10.patch \
    0003-third_party-sleef.patch \
    0004-caffe2.patch

  cd ..

  # rm -rf "python-build-${CARCH}" | true
  # cp -r "${_realname}-${pkgver}" "python-build-${CARCH}"

  cp -rup "${_realname}-${pkgver}/." "python-build-${CARCH}"

  # export VERBOSE=1

  export CMAKE_GENERATOR="MSYS Makefiles"
  export MAX_JOBS=1
  # export CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0"

  export USE_QNNPACK=OFF
  export USE_PYTORCH_QNNPACK=OFF
  export USE_NNPACK=OFF
  export USE_CUDA=OFF
  export USE_NUMPY=OFF

  # Temporary configuration
  export USE_FBGEMM=OFF
}

build() {
  cd "${srcdir}/python-build-${CARCH}"
  ${MINGW_PREFIX}/bin/python setup.py --quiet build
}

package() {
  cd "${srcdir}/python-build-${CARCH}"

  MSYS2_ARG_CONV_EXCL="--prefix=;--install-scripts=;--install-platlib=" \
    ${MINGW_PREFIX}/bin/python setup.py --quiet install --prefix=${MINGW_PREFIX} --root="${pkgdir}" -O1 --skip-build

  #install -Dm644 LICENSE.rst "${pkgdir}${MINGW_PREFIX}/share/licenses/python-${_realname}/LICENSE.rst"
}
