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