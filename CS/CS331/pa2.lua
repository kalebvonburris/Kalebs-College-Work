-- pa2.lua
-- Kaleb Burris
-- 2026-02-04
--
-- Assignment 2 for CS331



-- Exercise A answer:
-- "The Magic Words are Squeamish Ossifrage"



-- Exercise B --

local pa2 = {}

-- arrayFilter
-- Takes a given function `p` that acts as a filter -
-- a predicate, and returns an array of all values
-- (in order) that were true when input to `p`.
--
-- Note: `p` must be a single-input function.
--
-- Parameters:
-- + p: Function to appy to a given table.
-- + t: Table given to apply `p` onto.
--
-- Returns
-- + t_applied: An array that contains all given values that
-- evaluated to true by `p` onto `t`
function pa2.arrayFilter(p, t)
  local t_applied = {}
  local t_index = 1

  for _, value in ipairs(t) do
    if p(value) then
      t_applied[t_index] = value
      t_index = t_index + 1
    end
  end

  return t_applied
end

-- mostCommon
-- A function that takes a string `s` and non-negative
-- integer `n` and returns the most common substring
-- within `s` of size `n`.
--
-- Parameters
-- + s: A given substring of size >= `n`.
-- + n: A non-negative number of the size of substring
-- to check for.
--
-- Returns
-- + mostCommon_substr: The earliest, most common substring
-- in `s` that is of size `n`.
function pa2.mostCommon(s, n)
  local start_index, end_index = 1, n

  local substrings = {}

  while end_index <= s:len() do
    local substr = s:sub(start_index, end_index)

    if substrings[substr] == nil then
      substrings[substr] = 1
    else
      substrings[substr] = substrings[substr] + 1
    end

    start_index, end_index = start_index + 1, end_index + 1
  end

  -- I know no laws on name casing
  local mostCommon_substr, largest_count = "", 0

  for substr, count in pairs(substrings) do
    if count > largest_count then
      mostCommon_substr = substr
      largest_count = count
    elseif count == largest_count then
      -- Take the earliest substring
      -- We use "1, true" here to grab the first
      -- match, and to match plainly (no wildcards/special characters)
      local this_index, _ = s:find(substr, 1, true)
      local most_index, _ = s:find(mostCommon_substr, 1, true)
      if this_index < most_index then
        mostCommon_substr = substr
      end
    end
  end

  return mostCommon_substr
end

-- revSubstr
-- A coroutine that yields all substrings, reversed, of a
-- given string `s`.
--
-- Parameters
-- + s: A given string to yield substrings from.
--
-- Returns
-- + reversed_substrs: All substrings (including "")
-- that are reversed.
function pa2.revSubstr(s)
  coroutine.yield("")

  s = s:reverse()

  local substr_size = 1
  while substr_size <= s:len() do
    local start_index, end_index = 1, substr_size

    repeat
      local substr = s:sub(start_index, end_index)
      coroutine.yield(substr)
      start_index, end_index = start_index + 1, end_index + 1
    until end_index > s:len()

    substr_size = substr_size + 1
  end
end

-- collatzSeq
-- An iterator that yields the each value of the
-- Collatz sequence starting with `k` and ending at 0.
--
-- Parameters
-- + k: A positive integer that defines the input
-- for the Collatz function.
--
-- Returns
-- + A number of the Collatz sequence of `c(k)` depending on how many
-- times this function has been called.
function pa2.collatzSeq(k)
  local function collatz(n)
    if n % 2 == 1 then
      return n * 3 + 1
    else
      return n / 2
    end
  end

  return coroutine.wrap(function()
    -- Collatz sequence always starts with k
    coroutine.yield(k)

    local val = k

    while val ~= 1 do
      if val < 1 then
        return nil
      end
      val = collatz(val)
      coroutine.yield(val)
    end

    return nil
  end)
end

return pa2
