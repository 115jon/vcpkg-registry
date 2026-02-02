vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/yt-dlpp
  REF
  08141b181cf4a2b7dffc8bb04bf04c546ddf4aac
  SHA512
  29ba12eb9ee695cf32fcf01f594f321f5b075ae8c3cae1863ed1a4b930e1ceb1f1ce81306938f976b7e2d6520f6401f9748de65fb8a17ad38ea2b32cc759f1a2
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
