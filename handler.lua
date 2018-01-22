local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.myplugin.access"
local DynamicUpstreamHandler = BasePlugin:extend()

DynamicUpstreamHandler.PRIORITY = 10

function DynamicUpstreamHandler:new()
  DynamicUpstreamHandler.super.new(self, "myplugin")
end

function DynamicUpstreamHandler:access(conf)
  DynamicUpstreamHandler.super.access(self)
  access.execute(conf)
end

return DynamicUpstreamHandler