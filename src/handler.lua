local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.request-dynamic-transformer.access"
local RequestDynamicTransformerHandler = BasePlugin:extend()

RequestDynamicTransformerHandler.PRIORITY = 10

function RequestDynamicTransformerHandler:new()
  RequestDynamicTransformerHandler.super.new(self, "request-dynamic-transformer")
end

function RequestDynamicTransformerHandler:access(conf)
  RequestDynamicTransformerHandler.super.access(self)
  access.execute(conf)
end

RequestDynamicTransformerHandler.PRIORITY = 801
RequestDynamicTransformerHandler.VERSION = "0.1.0"

return RequestDynamicTransformerHandler