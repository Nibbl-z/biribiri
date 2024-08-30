biribiri = {}

local Timer = require("biribiri.timer")

local activeTimers = {}

function biribiri:CreateTimer(duration, call, loop)
    local t = Timer:New(duration, call, loop or false)
    
    table.insert(activeTimers, t)
    
    return t
end

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