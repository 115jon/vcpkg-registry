vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/ekizu
  REF
  397779d9a8a7d5e92e061a790fb8cf0b2d1aa638
  SHA512
  d4756d8486459257dd4cbbfcd5ee59c8b5f88d6647709433bf57b42a0e6746600f6e3dd6014d31daca13abeb262bac6a7fd1762a9249964a2ef4f5c0a327348d
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
