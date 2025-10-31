local _packages = {};
local packages = {};

local build_name = "disco";
local build_ver = "c++17";

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
        set_basename(build_name);
        set_kind("binary");
        add_files("frontend/*.cpp", "assets/placeholder.rc");
        add_packages(table.unpack(_packages));
    end
end