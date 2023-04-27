local GameManager = {}
GameManager.__index = GameManager

GameManager.CurrentGame = nil

function GameManager.Load()
    local gamemode = require("build/main")

    if gamemode then
        GameManager.CurrentGame = gamemode
        love.window.setTitle(gamemode.Name)

        local options = {}

        if (gamemode.WindowFullscreen) then
            options.fullscreen = true
        end

        if (gamemode.WindowResizable) then
            options.resizable = true
        end

        if (gamemode.VsyncEnabled) then
            options.vsync = true
        end

        love.window.setMode(gamemode.WindowWidth or 1200, gamemode.WindowHeight or 720, options)

        GameManager.CurrentGame.Load()
    else
        print("\n- Gamemode not found!")
    end
end

function GameManager.Update()
    if GameManager.CurrentGame then
        GameManager.CurrentGame.Update()
    end
end

_G.GameManager = GameManager
