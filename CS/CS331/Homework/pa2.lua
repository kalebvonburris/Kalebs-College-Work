-- pa2.lua
-- Kaleb Burris
-- 2024-02-11
--
-- For CS 331 Spring 2024
-- Test Program for Assignment 2 Functions
-- Used in Assignment 2, Exercise B
local pa2 = {}

function pa2.mapArray(f,t)
  local vals = {}
  for i, v in ipairs(t) do
    vals[i] = f(t[i])
  end
  return vals
end

function pa2.concatMax(s, i)
  local str = ""
  while str.len(str) + s.len(s) <= i do
    str = str..s
  end
  return str
end

function pa2.collatz(k)
  local n = k
  coroutine.yield(n)
  while n ~= 0 do
    if n == 1 then
      break
    end
    if math.fmod(n, 2) == 0 then
      n = math.floor(n / 2)
    else
      n = (3 * n) + 1
    end    
    coroutine.yield(n)
  end
end

function pa2.substrs(s)
  assert(type(s) == "string")
  local start, stop = 0, 0
  return function ()
    while true do
      if start == 0 and stop == 0 then
        stop = 1
        return ""
      elseif stop > #s then 
        return nil
      else
        while stop + start <= #s do
          start = start + 1
          return s:sub(start, start + stop - 1)
        end
        stop = stop + 1
        start = 0
      end
    end
  end
end

return pa2