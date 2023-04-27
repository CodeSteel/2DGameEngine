local GameManager = {}
GameManager.__index = GameManager

GameManager.CurrentGame = nil

function GameManager.Load()
    local gamemode = require("build/main")

    if gamemode then
        GameManager.CurrentGame = gamemode
        love.window.setTitle(gamemode.Name)
        GameManager.CurrentGame.Load()

        print("\n+ Gamemode set to '" .. gamemode.Name .. "'")
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
