local _packages = {};
local packages = {};

local build_name = "disco";
local build_ver = "c++17";

local is_debug = (
    is_mode("debug") or is_mode("releasedbg") and true
) or false;

do
    add_rules("plugin.compile_commands.autoupdate", {
        outputdir = ".vscode"
    })

    for package, config in pairs(packages) do 
        add_requires(package, {
            configs = config or {};
            plat = "windows";
            arch = "x64";
        })

        table.insert(_packages, package);
    end
end

do
    add_rules("mode.releasedbg", "mode.debug", "mode.release");
    set_languages(build_ver);

    target("frontend") do
        set_basename(is_debug and ("frontend") or build_name);
        set_kind("binary");
        add_files("frontend/*.cpp", "assets/placeholder.rc");
        add_packages(table.unpack(_packages));
    end

    target("backend") do
        set_basename(is_debug and ("backend") or build_name);
        set_kind("shared");
        add_files("backend/*.cpp");
        add_packages(table.unpack(_packages));
    end
end