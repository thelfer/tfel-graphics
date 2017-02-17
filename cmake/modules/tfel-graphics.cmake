macro(tfel_graphics_project tfel_graphics_version_major tfel_graphics_version_minor)
  project("tfel-graphics")
  set(PACKAGE_NAME "tfel-graphics")
  set(VERSION "${tfel_graphics_version_major}.${tfel_graphics_version_minor}")
  # the version number.
  set(TFEL_GRAPHICS_VERSION_MAJOR "${tfel_graphics_version_major}")
  set(TFEL_GRAPHICS_VERSION_MINOR "${tfel_graphics_version_minor}")
  add_definitions("-DVERSION=\\\"\"${tfel_graphics_version_major}.${tfel_graphics_version_minor}\"\\\"")
endmacro(tfel_graphics_project)

set(PACKAGE_BUGREPORT "tfel-contact@cea.fr")
add_definitions("-DPACKAGE_BUGREPORT=\\\"\"${PACKAGE_BUGREPORT}\"\\\"")
add_definitions("-DPACKAGE_NAME=\\\"\"${PACKAGE_NAME}\"\\\"")
add_definitions("-DPACKAGE=\\\"\"${PACKAGE_NAME}\"\\\"")
add_definitions("-DPACKAGE_VERSION=\\\"\"${tfel_graphics_version_major}.${tfel_graphics_version_minor}\"\\\"")

macro(install_header dir file)
  install(FILES ${dir}/${file}
          DESTINATION "include/${dir}")
endmacro(install_header)

macro(install_data dir file)
  install(FILES ${file}
          DESTINATION "share/${PACKAGE_NAME}/${dir}")
endmacro(install_data)

macro(tfel_graphics_library name)
if(${ARGC} LESS 1)
   message(FATAL_ERROR "tfel_graphics_library : no source specified")
endif(${ARGC} LESS 1)
add_library(${name} SHARED ${ARGN})
install(TARGETS ${name} DESTINATION lib)
if(ENABLE_STATIC)
 add_library(${name}-static STATIC ${ARGN})
 set_target_properties(${name}-static PROPERTIES OUTPUT_NAME "${name}")
 # Now the library target "${name}-static" will be named "${name}.lib"
 # with MS tools.
 # This conflicts with the "${name}.lib" import library corresponding
 # to "${name}.dll",
 # so we add a "lib" prefix (which is default on other platforms
 # anyway):
 set_target_properties(${name}-static PROPERTIES PREFIX "lib")
 # Help CMake 2.6.x and lower (not necessary for 2.8 and above, but
 # doesn't hurt):
 set_target_properties(${name}        PROPERTIES CLEAN_DIRECT_OUTPUT 1)
 set_target_properties(${name}-static PROPERTIES CLEAN_DIRECT_OUTPUT 1)
 install(TARGETS ${name}-static DESTINATION lib)
endif(ENABLE_STATIC)
endmacro(tfel_graphics_library)

macro(tfel_graphics_executable name)
if(${ARGC} LESS 1)
   message(FATAL_ERROR "tfel_graphics_executable : no source specified")
endif(${ARGC} LESS 1)
add_executable(${name} ${ARGN})
install(TARGETS ${name} DESTINATION bin)
endmacro(tfel_graphics_executable)
