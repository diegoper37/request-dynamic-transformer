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
  "lua ~> 5.1",
  "net-url ~> 0.9-1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.request-dynamic-transformer"] = "src/handler.lua",
    ["kong.plugins.request-dynamic-transformer"] = "src/access.lua",
    ["kong.plugins.request-dynamic-transformer"] = "src/schema.lua"
  }
}
