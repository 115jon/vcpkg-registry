vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/ekizu
  REF
  331e6fa899d01e95786fc00bfb3d40540582687e
  SHA512
  322e2a079db399b9caeb92e083701ff8923e45e96be3d2ea8e98c5d34a0e1953f95b99ea255b07398cf0467bfab7a8800ffa8a25f6cd744f1521984ea324ad3e
  HEAD_REF
  dev)

# Map features to CMake options INVERTED_FEATURES: when feature is ABSENT, the
# CMake option is ON
vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS INVERTED_FEATURES
                     boost EKIZU_USE_SYSTEM_BOOST)

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  -Dekizu_BUILD_EXAMPLES=OFF
  -Dekizu_BUILD_TESTS=OFF
  -Dekizu_INSTALL=ON
  ${FEATURE_OPTIONS})

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ekizu CONFIG_PATH lib/cmake/ekizu)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
