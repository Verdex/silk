
parse = require 'parse'

--[[
    { a = "blah"
    , b = 1234.1234
    , c = true
    , d = false
    , e = { a = b }
    , f = [ 1, 2, 3, 4 }
--]]

local parse_bool = function(p)
    local s, e = p:expect("true")
    if s then
        return true, true 
    end
    s, e = p:expect("false")
    if s then
        return true, false
    end
    return false, "expected boolean"
end

local parse_number = function(p)
    local s, e = p:parse_number()
    if not s then
        return false, e
    end
    return true, tonumber(e)
end

local parse_array = function(p)
    local s, e = p:expect("[")
    if not s then
        return false, e
    end
    s, e = p:list(parse_expr)
    local array = e
    if not s then
        return false, e
    end
    s, e = p:expect("]")
    if not s then
        return false, e
    end
    return true, array 
end

local parse_object = function(p)
    function parse_slot(p)
        return p:seq { function(p) return p:parse_symbol() end
                     ; function(p) return p:expect("=") end
                     ; parse_expr
                     }
    end

    print( 'blah') 

    local s, e = p:expect("{")
    if not s then 
        return false, e
    end

    s, e = p:zero_or_more(parse_slot)
    local slots = e

    if not s then 
        return false, e
    end

    s, e = p:expect("}")
    if not s then
        return false, e
    end

    local obj = {}
    for _, v in ipairs(slots) do
        obj[v[1]] = v[3]
    end

    return true, obj
end

local parse_expr = function(p)
    return p:choice{ parse_number 
                   ; function(p) return p:parse_string() end
                   ; parse_bool
                   ; parse_array
                   ; parse_object
                   }
end

local serialize = function( obj ) 
    
end

local deserialize = function( str )
    local p = parse.create_parser(str)
    return parse_expr(p)
end


return { serialize = serialize
       ; deserialize = deserialize
       }

