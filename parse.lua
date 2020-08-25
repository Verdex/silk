
local create_parser = function(input) 
    local o = {}
    o.input = input
    o.index = 1

    function is_end()
        return #o.input < o.index
    end

    function current()
        return string.sub(o.input, o.index, o.index)
    end

    function o:create_restore()
        return self.index
    end

    function o:restore(rp)
        self.index = rp
    end

    function o:clear()
        local i = string.match(self.input, "^%s*()", self.index)
        self.index = i
        return true
    end

    function o:expect_end()
        if is_end() then
            return true
        end
        return false
    end

    function o:expect( str )
        local s, e = self:clear()
        if not s then
            return false, e
        end

        local l = #str
        local i = 1
        local rp = self:create_restore()

        while i <= l do
            if is_end() then 
                self:restore(rp)
                return false, string.format("encountered end of file, but expected %s", str) 
            elseif current() ~= string.sub(str, i, i) then
                local err = string.format("encountered '%s' instead of '%s' when expecting '%s'"
                                         , current()  
                                         , string.sub(str, i, i)
                                         , str)

                self:restore(rp)
                return false, err
            else 
                self.index = self.index + 1 
                i = i + 1
            end
        end

        return true
    end

    function o:parse_symbol() 
        local s, e = self:clear()
        if not s then
            return false, e
        end

        local symbol, new_index = string.match(self.input, "^([_%a][_%w]*)()", self.index) 
        if not symbol then
            return false, string.format("encountered '%s' but expected symbol", current())
        end
        self.index = new_index
        return true, symbol
    end

    function o:parse_number()

    end

    function o:parse_string()

    end

    function o:maybe( parser )
        
    end

    function o:zero_or_more( parser )

    end
   
    function o:one_or_more( parser )

    end

    function o:list( parser )

    end

    function o:choice( parsers )

    end

    return o
end


return { create_parser = create_parser }
