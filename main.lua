require "biribiri"

function love.load()
    biribiri.LoadSprites("/img")
    
    timer = biribiri:CreateTimer(2, function ()
        print("gggup")
    end)
    
    biribiri:CreateAndStartTimer(0.5, function ()
        print("Hello!!")
    end, true)
    
    biribiri:CreateAndStartTimer(0.25, function ()
        print("ha")
    end)
    
    local mytable = {1,3,2,{["Working"] = {"So cool","and awesome","happy"}}}
    
    --for _, v in pairs(mytable) do print(v) end
    
    --print(table.find(mytable, 3))
    --print(table.tostring(mytable))
    table.clear(mytable)
    --for _, v in pairs(mytable) do print(v) end
    
    timer:Start()

    print(table.tostring(Sprites))    
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

function love.draw()
    love.graphics.draw(Sprites["/img/WHAT.png"])
    
    love.graphics.draw(Sprites["/img/these/andthose/angyfoo.jpg"], 200, 200, 50, 0.2, 0.2)
end