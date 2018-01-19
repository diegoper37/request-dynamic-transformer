-- -- If you're not sure your plugin is executing, uncomment the line below and restart Kong
-- -- then it will throw an error which indicates the plugin is being loaded at least.

-- --assert(ngx.get_phase() == "timer", "The world is coming to an end!")


-- -- Grab pluginname from module name
-- local plugin_name = ({...})[1]:match("^kong%.plugins%.([^%.]+)")

-- -- load the base plugin object and create a subclass
-- local plugin = require("kong.plugins.base_plugin"):extend()

-- -- constructor
-- function plugin:new()
--   plugin.super.new(self, plugin_name)
  
--   -- do initialization here, runs in the 'init_by_lua_block', before worker processes are forked

-- end

-- ---------------------------------------------------------------------------------------------
-- -- In the code below, just remove the opening brackets; `[[` to enable a specific handler
-- --
-- -- The handlers are based on the OpenResty handlers, see the OpenResty docs for details
-- -- on when exactly they are invoked and what limitations each handler has.
-- --
-- -- The call to `.super.xxx(self)` is a call to the base_plugin, which does nothing, except logging
-- -- that the specific handler was executed.
-- ---------------------------------------------------------------------------------------------


-- --[[ handles more initialization, but AFTER the worker process has been forked/created.
-- -- It runs in the 'init_worker_by_lua_block'
-- function plugin:init_worker()
--   plugin.super.access(self)

--   -- your custom code here
  
-- end --]]

--  runs in the ssl_certificate_by_lua_block handler
-- function plugin:certificate(plugin_conf)
--   plugin.super.access(self)

--   -- your custom code here
  
-- end 

-- --[[ runs in the 'rewrite_by_lua_block' (from version 0.10.2+)
-- -- IMPORTANT: during the `rewrite` phase neither the `api` nor the `consumer` will have
-- -- been identified, hence this handler will only be executed if the plugin is 
-- -- configured as a global plugin!
-- function plugin:rewrite(plugin_conf)
--   plugin.super.rewrite(self)

--   -- your custom code here
  
-- end --]]

-- ---[[ runs in the 'access_by_lua_block'
-- function plugin:access(plugin_conf)
--   plugin.super.access(self)

--   -- your custom code here
--   ngx.req.set_header("Hello-World", "this is on a request")
--   local upstream_url = ngx.ctx.api.upstream_url
--   -- local upstream_url_parts = url.parse(upstream_url)
--   print(upstream_url)
  
-- end --]]

-- ---[[ runs in the 'header_filter_by_lua_block'
-- function plugin:header_filter(plugin_conf)
--   plugin.super.access(self)

--   -- your custom code here, for example;
--   ngx.header["Bye-World"] = "this is on the response"

-- end --]]

-- --[[ runs in the 'body_filter_by_lua_block'
-- function plugin:body_filter(plugin_conf)
--   plugin.super.access(self)

--   -- your custom code here
  
-- end --]]

-- --[[ runs in the 'log_by_lua_block'
-- function plugin:log(plugin_conf)
--   plugin.super.access(self)

--   -- your custom code here
  
-- end --]]


-- -- set the plugin priority, which determines plugin execution order
-- plugin.PRIORITY = 1000

-- -- return our plugin object
-- return plugin


-- Extending the Base Plugin handler is optional, as there is no real
-- concept of interface in Lua, but the Base Plugin handler's methods
-- can be called from your child implementation and will print logs
-- in your `error.log` file (where all logs are printed).
local BasePlugin = require "kong.plugins.base_plugin"
local CustomHandler = BasePlugin:extend()

-- Your plugin handler's constructor. If you are extending the
-- Base Plugin handler, it's only role is to instanciate itself
-- with a name. The name is your plugin name as it will be printed in the logs.
function CustomHandler:new()
  CustomHandler.super.new(self, "myplugin")
end

function CustomHandler:init_worker(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.init_worker(self)

  -- Implement any custom logic here
end

function CustomHandler:certificate(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.certificate(self)

  -- Implement any custom logic here
end

function CustomHandler:rewrite(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.rewrite(self)

  -- Implement any custom logic here
end

function CustomHandler:access(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.access(self)
  for rep, uri in ipairs(config.replace.uri) do
    ngx.log(ngx.INFO,uri)
    if(string.find(ngx.var.uri,uri)) then
      ngx.log(ngx.INFO,"ok tem")
    else
      ngx.log(ngx.INFO,"nao tem")
    end    
  end

  
  -- ngx.log(ngx.INFO,string.gsub(ngx.var.uri, ""))

-- uris


  -- if api.uris then
  --   if type(api.uris) ~= "table" then
  --     return nil, "uris field must be a table"
  --   end

  --   if #api.uris > 0 then
  --     api_t.match_rules = bor(api_t.match_rules, MATCH_RULES.URI)

  --     for _, uri in ipairs(api.uris) do
  --       if re_find(uri, [[^[a-zA-Z0-9\.\-_~/%]*$]]) then
  --         -- plain URI or URI prefix

  --         local uri_t = {
  --           is_prefix = true,
  --           value     = uri,
  --         }

  --         api_t.uris[uri] = uri_t
  --         insert(api_t.uris, uri_t)

  --       else
  --         -- regex URI
  --         local strip_regex  = uri .. [[/?(?<stripped_uri>.*)]]
  --         local has_captures = has_capturing_groups(uri)

  --         local uri_t    = {
  --           is_regex     = true,
  --           value        = uri,
  --           regex        = uri,
  --           has_captures = has_captures,
  --           strip_regex  = strip_regex,
  --         }

  --         api_t.uris[uri] = uri_t
  --         insert(api_t.uris, uri_t)
  --       end
  --     end
  --   end
  -- end

  -- Implement any custom logic here
end

function CustomHandler:header_filter(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.header_filter(self)

  -- Implement any custom logic here
end

function CustomHandler:body_filter(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.body_filter(self)

  -- Implement any custom logic here
end

function CustomHandler:log(config)
  -- Eventually, execute the parent implementation
  -- (will log that your plugin is entering this context)
  CustomHandler.super.log(self)

  -- Implement any custom logic here
end

-- This module needs to return the created table, so that Kong
-- can execute those functions.
CustomHandler.PRIORITY = 1000
return CustomHandler
