# list(APPEND ANGLE_DEFINITIONS ANGLE_PLATFORM_LINUX EGL_NO_PLATFORM_SPECIFIC_TYPES USE_SYSTEM_EGL)
# include(linux.cmake)

if (USE_OPENGL)
    # Enable GLSL compiler output.
    list(APPEND ANGLE_DEFINITIONS ANGLE_ENABLE_GLSL)
endif ()

if (USE_ANGLE_EGL OR ENABLE_WEBGL)
    list(APPEND ANGLE_SOURCES
        ${gl_backend_sources}

        ${angle_system_utils_sources_linux}
        ${angle_system_utils_sources_posix}

        ${angle_dma_buf_sources}

        ${libangle_gl_egl_dl_sources}
        ${libangle_gl_egl_sources}
        ${libangle_gl_sources}

        ${libangle_gpu_info_util_sources}
        ${libangle_gpu_info_util_linux_sources}
    )

    list(APPEND ANGLE_DEFINITIONS
        ANGLE_ENABLE_OPENGL
    )

endif ()

list(APPEND ANGLE_DEFINITIONS
    GL_APICALL=
    GL_API=
    NOMINMAX
)

# We're targeting Windows 10 which will have DirectX 11
list(APPEND ANGLE_SOURCES
    ${d3d11_backend_sources}
    ${d3d_shared_sources}

    ${angle_translator_hlsl_sources}

    ${libangle_gpu_info_util_sources}
    ${libangle_gpu_info_util_win_sources}
)

list(APPEND ANGLE_DEFINITIONS
    ANGLE_ENABLE_D3D11
    ANGLE_ENABLE_HLSL
)

list(APPEND ANGLEGLESv2_LIBRARIES dxguid dxgi)

# DirectX 9 support should be optional but ANGLE will not compile without it
list(APPEND ANGLE_SOURCES ${d3d9_backend_sources})
list(APPEND ANGLE_DEFINITIONS ANGLE_ENABLE_D3D9)
list(APPEND ANGLEGLESv2_LIBRARIES d3d9 synchronization)

# Use shared libraries
set(GLESv2_LIBRARY_TYPE SHARED)
set(EGL_LIBRARY_TYPE SHARED)
