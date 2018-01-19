return {
  no_consumer = false, -- this plugin is available on APIs as well as on Consumers,
  fields = {
		replace = {
		  type = "table",
		  schema = {
		    fields = {
		      uri = {type = "array", default = {}}, -- does not need colons
		      body = {type = "array", default = {}}, -- does not need colons
		      headers = {type = "array", default = {}}, -- does not need colons
		      querystring = {type = "array", default = {}} -- does not need colons
		    }
		  }
		}	    
  },
  self_check = function(schema, plugin_t, dao, is_updating)
    -- perform any custom verification
    return true
  end
}
