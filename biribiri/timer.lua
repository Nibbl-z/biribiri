local timer = {}

function timer:New(duration, call, loop)
    o = {
        Duration = duration,
        Function = call,
        Looped = loop,
        
        Started = false,
        StartTime = 0,
        Paused = false,
        Finished = false,
        PauseStart = 0,
        PausedDuration = 0
    }

    setmetatable(o, self)
    self.__index = self
    
    return o
end

function timer:Start()
    if self.Started == true then return end

    self.Started = true
    self.StartTime = love.timer.getTime()
end

function timer:Pause()
    self.Paused = true
    self.PauseStart = love.timer.getTime()
end

function timer:Unpause()
    self.Paused = false
    self.PausedDuration = self.PausedDuration + love.timer.getTime() - self.PauseStart
end

return timer