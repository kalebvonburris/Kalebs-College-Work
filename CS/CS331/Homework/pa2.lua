-- pa2.lua
-- Kaleb Burris
-- 2025-02-12
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

function pa2.mostCommon(s)
  local occurances = {}
  -- Count each char
  for i = 1, #s do
    local char = s:sub(i, i)
    if occurances[char] == nil then
      occurances[char] = 1
    else
      occurances[char] = occurances[char] + 1
    end
  end

  -- Find the max value char
  if occurances == {} then
    return ""
  else 
    local max = 0
    local maxChar = ""
    for char, num in pairs(occurances) do
      if num > max then
        max = num
        maxChar = char
      elseif num == max then
        -- Return the first of the two
        for i = 1, #s do
          if s:sub(i, i) == maxChar then
            break
          end
          if s:sub(i, i) == char then
            maxChar = char
            break
          end
        end
      end
    end
    return maxChar
  end
end

function pa2.prefixSuffix(s)
  assert(type(s) == "string")
  -- Yield substrings from the start to the end
  for i = 0, #s do
    coroutine.yield(s:sub(1, i))
  end

  -- Yield substrings from the end to the start
  for i = 2, #s do
    coroutine.yield(s:sub(i, #s))
  end
end


function pa2.collatz(k)
  local n = k
  return function()
    if n ~= 0 then
      local current = n
      if n == 1 then
        n = 0
      elseif math.fmod(n, 2) == 0 then
        n = math.floor(n / 2)
      else
        n = (3 * n) + 1
      end    
      return current
    end
  end
end

return pa2