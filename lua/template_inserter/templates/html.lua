-- template_inserter/templates/html.lua
local M = {}

function M.get()
    return {
        "<!DOCTYPE html>",
        "<html>",
        "<head>",
        '    <meta charset="UTF-8">',
        "    <title>Document</title>",
        "</head>",
        "<body>",
        "",
        "</body>",
        "</html>",
    }
end

return M
