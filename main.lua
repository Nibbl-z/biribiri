require "biribiri"

function love.load()
    local timer = biribiri:CreateTimer(2, function ()
        print("gggup")
    end)
    
    biribiri:CreateAndStartTimer(0.5, function ()
        print("Hello!!")
    end, true)
    
    timer:Start()
end

function love.update(dt)
    biribiri:Update(dt)
end