cmake_minimum_required(VERSION 3.15)
project(flib Fortran)

# Prevent from root system installation
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/installed" CACHE PATH "default install path" FORCE)
    # Force update for sub-libraries (to follow current installation directive)
    set(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT FALSE CACHE BOOL "Installation prefix has been set" FORCE)
endif ()

set(FORTRAN_SRC addone.f)
set(HEADERS "include/${PROJECT_NAME}/flib.h"
)

add_library(${PROJECT_NAME} STATIC ${FORTRAN_SRC} ${HEADERS})

set(FLIBS_LIST ${FLIBS})
separate_arguments(FLIBS_LIST)

foreach(ITEM ${FLIBS_LIST})
    message(STATUS "Processing external lib option: ${ITEM}")
    string(SUBSTRING "${ITEM}" 0 2 SYMBOL)
    string(SUBSTRING "${ITEM}" 2 -1 VALUE)
    if (SYMBOL STREQUAL "-L")
        target_link_directories(${PROJECT_NAME} PUBLIC "${VALUE}")
    elseif (SYMBOL STREQUAL "-l")
        target_link_libraries(${PROJECT_NAME} PUBLIC "${VALUE}")
    else()
        message(FATAL_ERROR "Unknown option: ${ITEM}")
    endif()
endforeach()

# créer des variables de cache pour les destinations d'installation
include(GNUInstallDirs)

target_include_directories(
        ${PROJECT_NAME} INTERFACE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)

set_target_properties(${PROJECT_NAME} PROPERTIES POSITION_INDEPENDENT_CODE TRUE)

install(TARGETS ${PROJECT_NAME}
        EXPORT ${PROJECT_NAME}Targets
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} COMPONENT devel
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR} COMPONENT runtime
        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME} COMPONENT devel
)

install(FILES ${HEADERS} DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}")

install(EXPORT ${PROJECT_NAME}Targets
        FILE ${PROJECT_NAME}Config.cmake
        NAMESPACE ${PROJECT_NAME}::
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
