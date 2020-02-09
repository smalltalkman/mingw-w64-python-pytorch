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
        "0004-caffe2.patch"
        "0005-torch.patch"
        "0006-aten.patch")
sha256sums=('SKIP'
            'f3ab87bae12e3d6d664f873dc13c8272ba228377ffeefd8a759ba1d2c04216a1'
            '1cec246bcfcd01becdba4e4f925d98a8e8cf1f258095d29323466b45f538a8d9'
            '23a4b067e259ca6bac506390456e822027b42a90c71b6c373c316e4ceeaa9d42'
            'c58a17ae8e8a5c8ccca1a528b7b003ac9f2c4848a3ffea91dff4887b7825b707'
            'a32145ac91d9b8b2823264ea9bc275f426fc478b44348bb1c38feee7cb5d2f28'
            'b43012ac644d1bfa5c2eb9bf46f589c5302e69c3465649033f8560afe1fbba13')

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
    0004-caffe2.patch \
    0005-torch.patch \
    0006-aten.patch

  cd ..

  # rm -rf "python-build-${CARCH}" | true
  # cp -r "${_realname}-${pkgver}" "python-build-${CARCH}"

  cp -rup "${_realname}-${pkgver}/." "python-build-${CARCH}"

  # export VERBOSE=1

  export CMAKE_GENERATOR="MSYS Makefiles"
  export MAX_JOBS=1
  # export CXXFLAGS="-D_GLIBCXX_USE_CXX11_ABI=0"

  export USE_STATIC_DISPATCH=ON

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
