require "biribiri"

function love.load()
    timer = biribiri:CreateTimer(2, function ()
        print("gggup")
    end)
    
    biribiri:CreateAndStartTimer(0.5, function ()
        print("Hello!!")
    end, true)
    
    biribiri:CreateAndStartTimer(0.25, function ()
        print("ha")
    end)
    
    local mytable = {1,3,2}
    
    --for _, v in pairs(mytable) do print(v) end
    
    print(table.find(mytable, 3))
    
    table.clear(mytable)
    --for _, v in pairs(mytable) do print(v) end

    timer:Start()
end

function love.keypressed(key)
    if key == "e" then
        timer:Pause()
    elseif key == "q" then
        timer:Unpause()
    end
end

function love.update(dt)
    biribiri:Update(dt)
end