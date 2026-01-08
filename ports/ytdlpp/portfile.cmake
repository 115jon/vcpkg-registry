vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/yt-dlpp
  REF
  009507aa3a92be2e911516f0e0ecfbe6dd03d10b
  SHA512
  d79f879f8679ec69d02988a3db3ff7521985ee223a50d7a293a66866de1c0b31f3f11402d75d49321eac02aa2deacf30ee8d9865caa65cf21275e6f8c58e2c52
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
