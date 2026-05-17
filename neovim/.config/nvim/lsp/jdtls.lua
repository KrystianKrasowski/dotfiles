local home = vim.env.HOME
local jdtls_path = home .. "/.local/share/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

local root_markers = {
    ".git",
    ".gitignore",
    "mvnw",
    "gradlew",
    "pom.xml",
    "settings.gradle.kts",
    "build.gradle.kts",
    "settings.gradle",
    "build.gradle",
}

-- detect project root
local root_dir = vim.fs.root(0, root_markers)
if not root_dir then
    -- fallback if nothing matches
    root_dir = vim.fn.getcwd()
end

-- put workspace in it's own separate area
local workspace_dir = home .. "/.jdtls"

return {
    cmd = {
        "java",
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-Xms1g",
        "--add-modules=ALL-SYSTEM",
        "--add-opens", "java.base/java.util=ALL-UNNAMED",
        "--add-opens", "java.base/java.lang=ALL-UNNAMED",
        "-jar", launcher_jar,
        "-configuration", jdtls_path .. "/config_linux",
        "-data", workspace_dir,
    },

    filetypes = { "java" },
    root_markers = root_markers,
}
