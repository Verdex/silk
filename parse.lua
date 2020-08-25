
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
        local s, e = self:clear()
        if not s then
            return false, e
        end
        
        local number, new_index = string.match(self.input, "^(%d*.?%d*)()", self.index) 
        if not number then
            return false, string.format("encountered '%s' but expected number", current())
        end
        self.index = new_index
        return true, number 
    end

    function o:parse_string()
        local s, e = self:clear()
        if not s then
            return false, e
        end

        local rp = self:create_restore()

        s, e = self:expect('"')
        if not s then
            return false, e
        end

        local buffer = {}
        local escape = false

        while not is_end() do

            if escape and current() == '\\' then
                escape = false 
                self.index = self.index + 1
                buffer[#buffer+1] = '\\' 
            elseif escape and current() == 'n' then
                escape = false 
                self.index = self.index + 1
                buffer[#buffer+1] = '\n' 
            elseif escape and current() == 'r' then
                escape = false 
                self.index = self.index + 1
                buffer[#buffer+1] = '\r' 
            elseif escape and current() == 't' then
                escape = false 
                self.index = self.index + 1
                buffer[#buffer+1] = '\t' 
            elseif escape and current() == '0' then
                escape = false 
                self.index = self.index + 1
                buffer[#buffer+1] = '\0' 
            elseif escape and current() == '"' then
                escape = false 
                self.index = self.index + 1
                buffer[#buffer+1] = '\"' 
            elseif current() == '\\' then
                escape = true
                self.index = self.index + 1
            elseif current() == '"' then
                break
            elseif not escape then 
                buffer[#buffer+1] = current()
                self.index = self.index + 1
            else 
                return false, string.format("encountered unknown escape '%s'", current())
            end
        end
        
        if is_end() then
            return false, "encountered end of file inside of string"
        end

        s, e = self:expect('"')
        if not s then
            return false, e
        end
            
        return true, table.concat(buffer)
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
