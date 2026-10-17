project "AngelScript"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"
	warnings "off"
	pic "On"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"include/angelscript.h",
		"source/*.cpp",

		-- The add-ons the engine registers for every script (strings, arrays, math)
		-- and the builder that lets scripts use #include.
		"add_on/scriptstdstring/*.cpp",
		"add_on/scriptarray/*.cpp",
		"add_on/scriptbuilder/*.cpp",
		"add_on/scriptmath/*.cpp",
	}

	includedirs
	{
		"include",
		"add_on",
	}

	-- Every native function is registered through AngelScript's "generic" calling
	-- convention, so the engine never depends on the CPU or the compiler's calling
	-- convention. The same code then works on Linux, MinGW and MSVC with no assembly.
	defines { "AS_MAX_PORTABILITY" }

	filter "system:linux"
		systemversion "latest"
		links { "pthread" }

	filter "system:windows"
		systemversion "latest"
		defines { "_CRT_SECURE_NO_WARNINGS" }

	-- AngelScript's own build files ask GCC and Clang for this: its object code does
	-- type-punning that strict aliasing would let the optimizer break.
	filter "toolset:gcc or toolset:clang"
		buildoptions { "-fno-strict-aliasing" }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"
		symbols "off"
