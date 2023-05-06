local ls = require("luasnip")
print("SAL")

local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {cl = fmt("console.log({});", i(1))}
