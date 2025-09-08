local home = vim.env.HOME
local jdtls_path = home .. "/.local/share/jdtls"
local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

-- define markers once
local root_markers = {
    ".git",
    "mvnw",
    "gradlew",
    "pom.xml",
    "build.gradle",
}

-- detect project root
local root_dir = vim.fs.root(0, root_markers)
if not root_dir then
    root_dir = vim.fn.getcwd() -- fallback if nothing matches
end

-- put workspace inside project as ".jdtls/"
local workspace_dir = home .. "/.jdtls"

vim.lsp.config['jdtls'] = {
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
        "-configuration", jdtls_path .. "/config_linux", -- or config_mac/config_win
        "-data", workspace_dir,
    },

    filetypes = { "java" },
    root_markers = root_markers,
}
