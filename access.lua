-- local url = require "net.url"

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
  for rep, uriRole in ipairs(config.replace.uri) do 
      elements = splitRole(uriRole,"|")
      uri = elements[1]
      replace = elements[2]
      ngx.log(ngx.NOTICE,elements[1])
      ngx.log(ngx.NOTICE,elements[2])
    if(string.find(ngx.var.uri,uri)) then
      ngx.log(ngx.NOTICE,"ok tem")
    else
      ngx.log(ngx.NOTICE,"nao tem")
    end    
   end

  -- ngx.var.upstream_uri = "/request"  
end

function splitRole(source, delimiters)
        local elements = {}
        local pattern = '([^'..delimiters..']+)'
        string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
        return elements
  end

return _M
