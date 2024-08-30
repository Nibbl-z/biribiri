require "biribiri"

function love.load()
    local timer = biribiri:CreateTimer(2, function ()
        print("Hello!!")
    end)

    timer:Start()
end

function love.update(dt)
    biribiri:Update(dt)
end