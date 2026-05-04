local M = {}

local icon_dictionary = {
    ["default"] = "",
    ["cpp"] = "",
    ["c"] = "",
    ["lua"] = "󰢱",
    ["java"] = "",
    ["kotlin"] = "",
    ["markdown"] = "",
    ["sh"] = ""
}

function M.print(type)
    return icon_dictionary[type] or icon_dictionary["default"]
end

return M
