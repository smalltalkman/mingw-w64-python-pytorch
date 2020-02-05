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
        "0005-torch.patch")
sha256sums=('SKIP'
            'b22fae9cd3596910d774c660386787122f9c7be16f1e103cc0c0e2544ce554cf'
            'da79aa927e841d9e5c49b669cbe2d3529bb8cda383cfe77ec86662b0d8468cf0'
            '202d13def9203cc2b2bd3aee456d901fdb1f8f2c4f90f394bd62c566ec54725e'
            '8b59ce8a639f4d77ac97b56abb303ec45a84e52acf232fd321991eae83541e00'
            'a8b41468e5f803be6b3cc29bb2056205526bb31ddb120ad3703dd271d408a115')

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
    0005-torch.patch

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
