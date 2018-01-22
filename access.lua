-- local url = require "net.url"
local utils = require "kong.tools.utils"
local responses = require "kong.tools.responses"
local singletons = require "kong.singletons"
local req_get_headers = ngx.req.get_headers

local AUTHENTICATED_USERID = "authenticated_userid"


local _M = {}

-- local function buildHostHeader(newHost)
--   local u = url.parse(newHost)
--   local hostHeader = u.host
--   if u.port then
--     hostHeader = hostHeader .. ":" .. u.port
--   end
--   return hostHeader
-- end

-- local function replaceHost(url, newHost)
--   local pathIndex = url:find('[^/]/[^/]')

--   if not pathIndex then
--     if newHost:find('[^/]/[^/]') == nil and newHost:sub(#newHost) ~= "/" then
--       return newHost .. "/"
--     end

--     return newHost
--   end

--   if newHost:sub(#newHost) == "/" then
--     newHost = newHost:sub(1, -2)
--   end

--   local path = url:sub(pathIndex + 1)
--   return newHost .. path
-- end

function _M.execute(config)
  -- local hostHeader = buildHostHeader(conf.replacement_url) 
  userid = req_get_headers()["x-authenticated-userid"]
  newHost = ""
  for rep, uriRole in ipairs(config.replace.uri) do 
    
      elements = splitRole(uriRole,"|")
      uri = elements[1]
      replace = elements[2]
    if(string.find(ngx.var.uri,uri)) then     
      newHost = string.gsub(ngx.var.uri,uri,userid,2)
      ngx.log(ngx.NOTICE,newHost)
    end    
   end

  -- ngx.var.upstream_uri = "/request/" .. newHost  
end

function splitRole(source, delimiters)
        local elements = {}
        local pattern = '([^'..delimiters..']+)'
        string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
        return elements
  end

return _M
