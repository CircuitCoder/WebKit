set(WTF_OUTPUT_NAME WTFGTK)

list(APPEND WTF_SOURCES
    generic/MainThreadGeneric.cpp
    generic/WorkQueueGeneric.cpp

    glib/Application.cpp
    glib/ChassisType.cpp
    glib/FileSystemGlib.cpp
    glib/GRefPtr.cpp
    glib/GSocketMonitor.cpp
    glib/GSpanExtras.cpp
    glib/RunLoopGLib.cpp
    glib/Sandbox.cpp
    glib/SocketConnection.cpp
    glib/URLGLib.cpp

    win/CPUTimeWin.cpp
    win/FileSystemWin.cpp
    win/OSAllocatorWin.cpp
    win/ThreadingWin.cpp
    win/SignalsWin.cpp

    text/win/StringWin.cpp
    text/win/TextBreakIteratorInternalICUWin.cpp

    win/LanguageWin.cpp
    win/LoggingWin.cpp

    win/DbgHelperWin.cpp
    win/Win32Handle.cpp
)

list(APPEND WTF_PUBLIC_HEADERS
    glib/Application.h
    glib/ChassisType.h
    glib/GMutexLocker.h
    glib/GRefPtr.h
    glib/GSocketMonitor.h
    glib/GSpanExtras.h
    glib/GThreadSafeWeakPtr.h
    glib/GTypedefs.h
    glib/GUniquePtr.h
    glib/GWeakPtr.h
    glib/RunLoopSourcePriority.h
    glib/Sandbox.h
    glib/SocketConnection.h
    glib/SysprofAnnotator.h
    glib/WTFGType.h

    text/win/WCharStringExtras.h

    win/DbgHelperWin.h
    win/GDIObject.h
    win/PathWalker.h
    win/SoftLinking.h
    win/Win32Handle.h

    # linux/CurrentProcessMemoryStatus.h
    # linux/ProcessMemoryFootprint.h
    # linux/RealTimeThreads.h

    # unix/UnixFileDescriptor.h
)

if (CMAKE_SYSTEM_NAME MATCHES "Linux")
    list(APPEND WTF_SOURCES
        linux/CurrentProcessMemoryStatus.cpp
        linux/MemoryFootprintLinux.cpp
        linux/RealTimeThreads.cpp

        unix/MemoryPressureHandlerUnix.cpp
    )
elseif (CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
    list(APPEND WTF_SOURCES
        generic/MemoryFootprintGeneric.cpp

        unix/MemoryPressureHandlerUnix.cpp
    )
elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
    list(APPEND WTF_SOURCES
        win/MemoryFootprintWin.cpp
        win/MemoryPressureHandlerWin.cpp
    )

    list(APPEND WTF_LIBRARIES
        DbgHelp
        shlwapi
        winmm
    )
else ()
    list(APPEND WTF_SOURCES
        generic/MemoryFootprintGeneric.cpp
        generic/MemoryPressureHandlerGeneric.cpp
    )
endif ()

list(APPEND WTF_LIBRARIES
    ${GLIB_GIO_LIBRARIES}
    ${GLIB_GOBJECT_LIBRARIES}
    ${GLIB_LIBRARIES}
    Threads::Threads
    ZLIB::ZLIB
)

if (ENABLE_JOURNALD_LOG)
    list(APPEND WTF_LIBRARIES Journald::Journald)
endif ()

list(APPEND WTF_SYSTEM_INCLUDE_DIRECTORIES
    ${GIO_UNIX_INCLUDE_DIRS}
    ${GLIB_INCLUDE_DIRS}
)

if (USE_LIBBACKTRACE)
    list(APPEND WTF_LIBRARIES
        LIBBACKTRACE::LIBBACKTRACE
    )
endif ()

if (USE_SYSPROF_CAPTURE)
    list(APPEND WTF_LIBRARIES
        SysProfCapture::SysProfCapture
    )
endif ()
