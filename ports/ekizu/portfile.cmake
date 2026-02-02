vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/ekizu
  REF
  e27421dfe88a65bf1703c807131c8279f85a37d1
  SHA512
  8d1d71ed79968af8b26c333365cea6ab4a06b44a2a24c603715d051874a6a6a19c3c78d8c518e046284f087be3e142c8d772f7e7dde165fbb5d799b02815d209
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
