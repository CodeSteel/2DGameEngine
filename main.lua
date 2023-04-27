require('modules')

_G.love = love

function love.load()
    Config.Load()

    local options = {}

    if (Config.Get("fullscreen")) then
        options.fullscreen = true
    end

    if (Config.Get("resizable")) then
        options.resizable = true
    end

    if (Config.Get("vsync")) then
        options.vsync = true
    end

    love.window.setTitle(Config.Get("gamemode"))
    love.window.setMode(Config.Get("window-width"), Config.Get("window-height"), options)

    Game.Start()
    GameManager.Load()
end

function love.update(dt)
    Game.FrameTime = dt
    Game.Update()
    GameManager.Update()
    ObjectManager.Update()
end

function love.draw()
    Game.Draw()
    ObjectManager.Draw()
end
