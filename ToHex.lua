-- Encode bytes
function tobits(num)
    return string.format("%x", string.byte(num))
end

function encode(str)
    local result = ""
    for i = 1, str:len() do
        result = result .. tobits(str:sub(i, i)) .. " "
    end
    return result
end

local decodeSource = [[function decode(str)
    local result = ""
    local last = ""
    for i = 1, str:len() do
        local char = str:sub(i, i)
        if char == " " then
            if last ~= "" then
            print(last)
                result = result .. string.char(tonumber(last, 16))
                last = ""
            end
        else
            last = last .. char
        end
    end
    return result
end]]
loadstring(decodeSource)() -- create decode function

function encode2(str)
    return decodeSource .. "\r\nlocal encoded = [[" .. str .. "]]\r\nloadstring(decode(encoded))()"
end

local code = [[local str = "Hello world!"
print(str)]] -- could be game.Workspace["A script to obfuscate..."].Source
local enc = encode2(encode(code))
--local dec = decode(enc)
--print("Encoded: ", enc)
--print("Decoded: ", dec)
print("Output: ")
--loadstring(dec)()
loadstring(enc)()
