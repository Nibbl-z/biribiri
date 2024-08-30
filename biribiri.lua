biribiri = {}

local Timer = require("biribiri.timer")

local activeTimers = {}

function biribiri:CreateTimer(duration, call)
    local t = Timer:New(duration, call)

    table.insert(activeTimers, t)

    return t
end

function biribiri:Update(dt)
    for _, timer in ipairs(activeTimers) do
        if timer.Started and not timer.Paused and not timer.Finished then
            if love.timer.getTime() >= timer.StartTime + timer.PausedDuration + timer.Duration then
                timer.Function()
                timer.Finished = true
            end
        end
    end
end

--biribiri.