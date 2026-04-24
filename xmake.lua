local load_packages do 
    -- uptightsuperlabs - 4/24/2026 just some packages I tend to use.
    local requires = {
        ["sailormoon_flags"] = {},
        ["fmt"] = {}
    }

    for require, config in pairs(requires) do 
        config = config or {};
        config["static"] = true;
        config["shared"] = false;

        add_requires(require, {
            configs = config;
            plat = "windows";
            arch = "x64";
        })
    end

    ---
    --  uptightsuperlabs - 4/24/2026
    --  
    --  You can add custom packages and linker items and thinks like that here.
    --  The syntax is simple (Note: Function is incomplete!):
    --
    ---
    --  I tend to also add other things besides packages, like syslinks, and debug stuff.
    ---
    --
    --  requires["jvm"] = function()
    --      add_includedirs(path_join(jdk_path, "include". "win32", "bridge"));
    --      add_includedirs(path_join(jdk_path, "include", "win32"));
    --      add_includedirs(path_join(jdk_path, "include"));
    --
    --      add_linkdirs(path_join(jdk_path, "lib"));
    --      add_links("jvm");
    --  end
    ---

    requires["__syslinks"] = function()
        add_syslinks(
            "kernel32",
            "user32",
            "shell32",
            "advapi32"
        )
    end

    requires["__debug"] = function()
        if (is_mode("debug")) then
            add_defines("DEBUG");
        end
    end

    function load_packages(target)
        for package, _callback in pairs(requires) do
            if (_callback) and (type(_callback) == "function") then
                _callback(target);
            else
                add_packages(package);
            end
        end
    end
end 

do
    set_toolchains("clang-cl"); -- uptightsuperlabs - 4/24/2026 I prefer to use clang-cl over msvc!!
    set_languages("c++23");
    set_project("Project");
    add_rules("mode.releasedbg", "mode.debug", "mode.release");

    target("binary") do
        set_kind("binary");
        add_files("src/**.cpp");
        load_packages();
    end

    target("module") do
        set_kind("shared");
        add_files("module/**.cpp");
        load_packages();
    end
end