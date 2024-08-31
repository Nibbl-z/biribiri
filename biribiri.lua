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

table.clear = function (t)
    for _, v in pairs(t) do
        table.remove(t, #t - 1)
    end
    table.remove(t, 1)
end

table.find = function (haystack, needle)
    for i, v in pairs(haystack) do
        if v == needle then
            return i
        end
    end

    return nil
end

math.clamp = function (number, min, max)
    if number == nil then
        error("Number was not provided!")
    end
    
    if min > max then

        error("max must be larger than min!")
    end

    return math.max(min, math.min(max, number))
end

math.round = function (number, multiple)
    return math.floor(number / multiple + 0.5) * multiple
end

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
        
        if type(value) ~= "table" then
            str = str..value
        else
            str = str..TableToString(value)
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

table.tostring = function(t)
    return TableToString(t)
end