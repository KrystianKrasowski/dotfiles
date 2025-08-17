local colors = {
    bg         = "#2D2A2E",
    fg         = "#FCFCFA",
    pink       = "#FF6188",
    orange     = "#FC9867",
    yellow     = "#FFD866",
    green      = "#A9DC76",
    blue       = "#78DCE8",
    purple     = "#AB9DF2",
    comment    = "#727072",
    cursorline = "#3E3D41",
}

-- Clear existing highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.o.background = "dark"
vim.g.colors_name = "monokai_pro"

-- Short helper
local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Basic editor UI
hl("Normal", { fg = colors.fg, bg = colors.bg })
hl("Comment", { fg = colors.comment, italic = true })
hl("CursorLine", { bg = colors.cursorline })
hl("Visual", { bg = "#403E41" })
hl("LineNr", { fg = "#5B595C" })
hl("CursorLineNr", { fg = colors.yellow, bold = true })
hl("VertSplit", { fg = "#403E41" })
hl("StatusLine", { fg = colors.fg, bg = "#403E41" })
hl("StatusLineNC", { bg = colors.bg })
hl("Operator", { fg = colors.pink })

-- Status line
hl("StatuslineModeNormal", { fg = colors.fg })
hl("StatuslineModeNormalTemp", { fg = colors.yellow })
hl("StatuslineModeInsert", { bg = colors.blue, fg = colors.bg })
hl("StatuslineModeVisual", { bg = colors.orange, fg = colors.bg })
hl("StatuslineModeReplace", { bg = colors.blue, fg = colors.bg })
hl("StatuslineModeCommand", { bg = colors.green, fg = colors.bg })
hl("StatuslineModeTerminal", { bg = colors.green, fg = colors.bg })
hl("StatuslineErrorsCount", { fg = colors.pink })
hl("StatuslineErrorsNone", { fg = colors.green })

-- tabline
hl("TabLineSel", { bg = colors.comment })

-- Syntax
hl("Keyword", { fg = colors.pink, bold = true })
hl("Identifier", { fg = colors.blue })
hl("Function", { fg = colors.green })
hl("String", { fg = colors.yellow })
hl("Number", { fg = colors.purple })
hl("Boolean", { fg = colors.purple })
hl("Type", { fg = colors.blue })
hl("Constant", { fg = colors.purple })
hl("Statement", { fg = colors.pink })
hl("PreProc", { fg = colors.pink })
hl("Special", { fg = colors.yellow })

-- Lsp
hl("@lsp.type.property", { fg = colors.fg, italic = true })
hl("@lsp.type.parameter", { fg = colors.fg, bold = true })
hl("@lsp.mod.usedAsMutableReference", { underline = true })
hl("@lsp.mod.constructorOrDestructor", { fg = colors.green, bold = true })

-- Diagnostics
hl("DiagnosticError", { fg = colors.pink })
hl("DiagnosticWarn", { fg = colors.yellow })
hl("DiagnosticInfo", { fg = colors.blue })
hl("DiagnosticHint", { fg = colors.green })
