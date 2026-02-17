vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/yt-dlpp
  REF
  d258ca263b038fbc70fb7ca2a400a55185201414
  SHA512
  198d7e9ca438b2dc8a17a12baa131ddb2940ed7e7c83b95655541030165b67527688ecad3780a71f49d02e6336734ea5f1cd75afc5cd043c3dd4fda454b0697c
  HEAD_REF
  main)

# Map features to CMake options INVERTED_FEATURES: when feature is ABSENT, the
# CMake option is ON
vcpkg_check_features(
  OUT_FEATURE_OPTIONS
  FEATURE_OPTIONS
  INVERTED_FEATURES
  boost
  YTDLPP_USE_SYSTEM_BOOST
  ffmpeg
  YTDLPP_USE_SYSTEM_FFMPEG)

vcpkg_cmake_configure(
  SOURCE_PATH
  "${SOURCE_PATH}"
  OPTIONS
  -DYTDLPP_BUILD_CLI=OFF
  -DYTDLPP_BUILD_EXAMPLES=OFF
  -DYTDLPP_BUILD_TESTS=OFF
  -DYTDLPP_INSTALL=ON
  ${FEATURE_OPTIONS})

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME ytdlpp CONFIG_PATH lib/cmake/ytdlpp)
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Install usage file and license
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

if(EXISTS "${SOURCE_PATH}/LICENSE")
  vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
else()
  file(WRITE "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
       "See source repository for license information.")
endif()
