
project "AngelScript"
    kind "StaticLib"
    language "C++"
    cppdialect "C++17"
    staticruntime "Off"
    warnings "Off"
    pic "On"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "sdk/angelscript/include/angelscript.h",
        "sdk/angelscript/source/*.cpp",

        "sdk/add_on/scriptstdstring/*.cpp",
        "sdk/add_on/scriptarray/*.cpp",
        "sdk/add_on/scriptstdstring_utils/*.cpp",
        "sdk/add_on/scriptbuilder/*.cpp",
        "sdk/add_on/scriptmath/*.cpp",
    }

    includedirs
    {
        "sdk/angelscript/include",
        "sdk/add_on",
    }

    defines { "AS_MAX_PORTABILITY" }

    filter "system:linux"
        links { "pthread" }

    filter "system:windows"
        defines { "_CRT_SECURE_NO_WARNINGS" }

    filter "toolset:gcc or toolset:clang"
        buildoptions { "-fno-strict-aliasing" }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "On"

    filter "configurations:Release"
        runtime "Release"
        optimize "On"

    filter "configurations:Dist"
        runtime "Release"
        optimize "On"
        symbols "Off"

    filter {}
