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

        Game.WindowWidth = gamemode.WindowWidth or 1200
        Game.WindowHeight = gamemode.WindowHeight or 720
        Game.WindowFullscreen = gamemode.WindowFullscreen or false
        Game.WindowResizable = gamemode.WindowResizable or false
        Game.VsyncEnabled = gamemode.VsyncEnabled or false
        Game.BackgroundColor = gamemode.BackgroundColor or color_black

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

function GameManager.Draw()
    local col = Game.BackgroundColor
    love.graphics.setBackgroundColor(col.r / 255, col.g / 255, col.b / 255, col.a / 255)
end

_G.GameManager = GameManager
