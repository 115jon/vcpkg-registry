vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/ekizu
  REF
  145c61091d7fbb952126a0b9e51703a65bd1bf60
  SHA512
  aed4b67cc6f6305c5e21ccedcdfbbf7c465b5f2c5178853311a8d451b3eadbb0dffa77b88a1155d6ea8c7e53961eb955a9a7f55864db7b70c6f95daa0fc931fb
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

# Install usage file and license
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
