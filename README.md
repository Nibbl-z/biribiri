# Biribiri

A Love2D library with a bunch of useful tools, including timers, Luau `math` and `table` functions, and an easy way to load assets.

![Example](https://cloud-fiivhgico-hack-club-bot.vercel.app/0image.png)

### Setup

Download `biribiri.lua` and the `biribiri` folder and put them in the root of your project. Call `require("biribiri")` at the top of your script to access its features.
Also, make sure to call `biribiri:Update()` in `love.update()` to make timers functional.

### Examples:

Print "Hello!!" after 0.5 seconds
```lua
biribiri:CreateAndStartTimer(0.5, function ()
        print("Hello!!")
end, false)
```

Load the `img` folder into the global `assets` table, which can be used in `love.draw`
```lua
biribiri:LoadSprites("img")
```
