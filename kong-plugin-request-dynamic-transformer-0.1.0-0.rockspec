package = "kong-plugin-request-dynamic-transformer"
version = "0.1.0-0"
source = {
  url = "git://github.com/diegoper37/request-dynamic-transformer"
}
description = {
  summary = "A Kong plugin that sets different upstream URLs based on dynamic parameters",
  license = "Apache 2.0"
}
dependencies = {
  "lua ~> 5.1"
}
local pluginName = "request-dynamic-transformer"
build = {
  type = "builtin",
  modules = {
    ["kong.plugins."..pluginName..".handler"] = "src/handler.lua",
    ["kong.plugins."..pluginName..".schema"] = "src/schema.lua",
    ["kong.plugins."..pluginName..".access"] = "src/access.lua",
  }
}
