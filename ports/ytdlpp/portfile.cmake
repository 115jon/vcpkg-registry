vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/yt-dlpp
  REF
  33f0162c5c5ec9d4ebda12fa03dc960060034126
  SHA512
  8d50a683b5cfcc5dd4efa19d0445c748fc5511a6ca74c24a2653c2fb25bc72e1675eafb4b01c5d47e599c59b8753c3d33e2fe5b6f6eeb32b120334f5855f2793
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
