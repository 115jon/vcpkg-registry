vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/ekizu
  REF
  02b8feef92ce5a1dfdd560f1da3b73b2e5703224
  SHA512
  255f17ee14a09da02fb9ab3f23b7ae8af33e3352f5e0f7641c6ee3ced21a5d0c4ed37db56654f3c1c8db2e8a04acacf51d40922cfbfc997a7787884c8fe2c9a0
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
