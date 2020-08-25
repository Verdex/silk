
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
        local i = string.match(self.input, "%s*()", self.index)
        self.index = i
        return true
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

    function o:maybe( parser )
        
    end

    
    return o
end


return { create_parser = create_parser }
