require "biribiri"

function love.load()
    biribiri:LoadSprites("img")
    biribiri:LoadAudio("sound", "stream")
    
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
    
    timer:Start()

    print(table.tostring(mytable))    
end

function love.keypressed(key)
    if key == "e" then
        timer:Pause()
        assets["sound/green goose.ogg"]:play()
    elseif key == "q" then
        timer:Unpause()
    end
end

function love.update(dt)
    biribiri:Update(dt)
end

function love.draw()
    love.graphics.draw(assets["img/WHAT.png"])
    
    love.graphics.draw(assets["img/these/andthose/angyfoo.jpg"], 200, 200, 50, 0.2, 0.2)
end