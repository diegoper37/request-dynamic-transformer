-- local url = require "net.url"
local utils = require "kong.tools.utils"
local responses = require "kong.tools.responses"
local singletons = require "kong.singletons"
local req_get_headers = ngx.req.get_headers
local req_set_headers = ngx.req.set_header
local print_r = require 'pl.pretty'.dump
local cjson = require "cjson.safe"

local AUTHENTICATED_USERID = "authenticated_userid"


local _M = {}

-- Exemplo de como gravar regra
-- ^\/customer\/(\w*)|2:x-authenticated-userid

function _M.execute(config)
  local var_sub = {}   
  req_set_headers("x-authenticated-userid", 225) -- TEM QUE TIRAR PARA PROD
  local uriParts = splitRole(ngx.var.uri,"/") 
  local tempUri = "/"
  local deuMatch = false
  for rep, replaces in ipairs(config.replace.uri) do
    local tmpReplace = splitRole(replaces,"|")
    local uriFind = tmpReplace[1]    
    local m = ngx.re.match(ngx.var.uri, uriFind,"i");
    if m then 
      deuMatch = true
      local uriReplace = splitRole(tmpReplace[2],":")
      local posicao = tonumber(uriReplace[1])      
      for i = 1, #uriParts, 1 do
        if i == posicao then
          if not req_get_headers()[uriReplace[2]] then
            return responses.send_HTTP_FORBIDDEN("You cannot consume this service")
          end
          uriParts[i] = req_get_headers()[uriReplace[2]]
        end
        tempUri = tempUri .. uriParts[i] .. "/"
      end
    end    
  end    
  if deuMatch then
    local nova = ngx.re.sub(ngx.var.upstream_uri,ngx.var.uri,"") .. tempUri    
    ngx.var.upstream_uri = nova
  end
end

function splitRole(source, delimiters)
        local elements = {}
        local pattern = '([^'..delimiters..']+)'
        string.gsub(source, pattern, function(value) elements[#elements + 1] =     value;  end);
        return elements
end

return _M
