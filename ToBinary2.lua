-- Reverse bytes
function reverse(t)
  local nt = { } -- new table
  local size = #t + 1
  for k, v in ipairs(t) do
    nt[size - k] = v
  end
  return nt
end

-- Encode bytes
function tobits(num)
    local t={ }
    while num > 0 do
        rest = num % 2
        t[#t + 1] = rest
        num = (num - rest) / 2
    end
    t = reverse(t)
    return table.concat(t)
end

function fix(s)
    while s:len() < 8 do
        s = "0" .. s
    end
    return s
end

function encode(str)
    local result = ""
    for i = 1, str:len() do
        result = result .. fix(tobits(str:sub(i, i):byte()))-- .. " "
    end
    return result
end

local decodeSource = [[function decode(str)
    local result = ""
    local last = ""
    for i = 1, str:len() do
        local char = str:sub(i, i)
        if last:len() == 8 then
            if last ~= "" then
                result = result .. string.char(tonumber(last, 2))
                last = ""
            end
            last = char
        else
            last = last .. char
        end
    end
    result = result .. string.char(tonumber(last, 2))
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
