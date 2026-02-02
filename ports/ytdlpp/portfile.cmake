vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/yt-dlpp
  REF
  911ab3f06eb41b1949b7f739b2bd47959ddaf38c
  SHA512
  47339bb6c6444559db4518716bfb87dbac7cbe17d70ba4f2602ad88d0f5d3c5f07c274c81d8f602ba42672543a04056762afafafb912b59046120c02d330d2e0
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
