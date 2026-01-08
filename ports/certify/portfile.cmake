vcpkg_from_github(
  OUT_SOURCE_PATH
  SOURCE_PATH
  REPO
  115jon/certify
  REF
  f58255e4489a94fe4a8bcc6d046877f6e6928938
  SHA512
  23194d8050ef02a0ed9098fc176a1d0a4cd90e8dffb30f9c55f6f22ae498ecf8fa17ed4a0193df49542289a1e9b65488912397007df96dae851954d86cd580b6
  HEAD_REF
  master)

vcpkg_cmake_configure(SOURCE_PATH "${SOURCE_PATH}" OPTIONS -DCERTIFY_INSTALL=ON
                      -DCERTIFY_BUILD_TESTS=OFF)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/certify)

# Certify is header-only, remove empty directories
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Install usage file and license
file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
     DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE_1_0.txt")
