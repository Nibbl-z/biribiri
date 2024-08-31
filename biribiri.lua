biribiri = {}

local Timer = require("biribiri.timer")

local activeTimers = {}

--- Creates a timer and then returns it
---@param duration number How many seconds until the function should be called?
---@param call function The function to call after the duration ends
---@param loop boolean? Should the timer loop after ending?
---@return Timer
function biribiri:CreateTimer(duration, call, loop)
    local t = Timer:New(duration, call, loop or false)
    
    table.insert(activeTimers, t)
    
    return t
end

--- Creates a timer, starts it, and then returns it
---@param duration number How many seconds until the function should be called?
---@param call function The function to call after the duration ends
---@param loop boolean? Should the timer loop after ending?
---@return Timer
function biribiri:CreateAndStartTimer(duration, call, loop)
    local t = Timer:New(duration, call, loop or false)
    
    table.insert(activeTimers, t)
    t:Start()
    
    return t
end

function biribiri:Update(dt)
    for _, timer in ipairs(activeTimers) do
        if timer.Started and not timer.Paused and not timer.Finished then
            if love.timer.getTime() >= timer.StartTime + timer.PausedDuration + timer.Duration then
                timer.Function()
                timer.Finished = true
                timer.Started = false
                timer.PausedDuration = 0
                
                if timer.Looped then
                    timer.Finished = false
                    timer:Start()
                end
            end
        end
    end
end

--- Clears a table
--- @param t table The table to clear
table.clear = function (t)
    for _, v in pairs(t) do
        table.remove(t, #t - 1)
    end
    table.remove(t, 1)
end

--- Finds a value inside of a table, returns the index if it is found, and returns nil otherwise
--- @param haystack table The table to search
--- @param needle any The value to look for
--- @return number|nil
table.find = function (haystack, needle)
    for i, v in pairs(haystack) do
        if v == needle then
            return i
        end
    end

    return nil
end

--- Returns number between the min and max boundaries
---@param number number The number to clamp
---@param min number The minimum value of the number
---@param max number The maximum value of the number
---@return number clampedNumber
math.clamp = function (number, min, max)
    if number == nil then
        error("Number was not provided!")
    end
    
    if min > max then

        error("max must be larger than min!")
    end

    return math.max(min, math.min(max, number))
end

--- Rounds the number to the nearest multiple provided or the nearest integer if a multiple is not provided
---@param number number The number to round
---@param multiple? number The multiple to round the number to
---@return number number
math.round = function (number, multiple)
    multiple = multiple or 1
    return math.floor(number / multiple + 0.5) * multiple
end

--- Returns the length of a table. You can use this instead of # on key-value tables because for whatever reason, # doesn't work on key-value tables.
---@param t table Table to get the length of
---@return number count
table.length = function (t)
    local count = 0
    
    for _, _ in pairs(t) do
        count = count + 1
    end

    return count
end

local function TableToString(t)
    local str = "{"
    local index = 1
    
    for key, value in pairs(t) do
        if type(key) ~= "number" then
            str = str..string.format("[\"%s\"] = ", key)
        end
        
        if type(value) == "string" then
            str = str.."\""..value.."\""
        elseif type(value) == "table" then
            str = str..TableToString(value)
        else
            str = str..value
        end

        if index == table.length(t) then
            str = str.."}"
        else
            str = str..","
        end

        index = index + 1
    end

    return str
end

--- Serializes the table provided as a string, e.g. to print a table and see it's values instead of the memory location
---@param t table Table to convert to a string
---@return string serializedTable
table.tostring = function(t)
    return TableToString(t)
end

--- Gets the X and Y distance between two XY coordinates.
---@param x1 number X coordinate 1
---@param y1 number Y coordinate 1
---@param x2 number X coordinate 2
---@param y2 number Y coordinate 2
---@return number distance Distance
biribiri.distance = function (x1, y1, x2, y2)
    local dx = x1 - x2
    local dy = y1 - y2
    return math.sqrt (dx * dx + dy * dy)
end