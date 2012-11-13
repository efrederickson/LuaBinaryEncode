-- Encode bytes
function tobits(num)
    local c = string.format("%x", string.byte(num)):upper()
    while c:len() < 2 do c = "0" .. c end
    return c
end

function encode(str)
    local result = ""
    for i = 1, str:len() do
        result = result .. tobits(str:sub(i, i))
    end
    return result
end

local decodeSource = [[function decode(str)
    local result = ""
    for i = 1, str:len(), 2 do
        result = result .. string.char(tonumber(str:sub(i, i + 1), 16))
    end
    return result
end]]
loadstring(decodeSource)() -- create decode function

function encode2(str)
    return decodeSource .. "\r\nlocal encoded = [[" .. str .. "]]\r\loadstring(decode(encoded))()"
end

local code = [[local str = "Hello world!"
print(str)]] -- could be game.Workspace["A script to obfuscate..."].Source
local enc = encode(code)
local dec = decode(enc)
--print("Encoded: ", enc)
--print("Decoded: ", dec)
print("Output: ")
enc = encode2(enc)
--loadstring(dec)()
loadstring(enc)()
