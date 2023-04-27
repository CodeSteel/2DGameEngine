local GameManager = {}
GameManager.__index = GameManager

GameManager.CurrentGame = nil

function GameManager.Load()
    GameManager.CustomGames = {}

    local files = love.filesystem.getDirectoryItems("gamemode")
    for k, v in pairs(files) do
        if love.filesystem.getInfo("gamemode/" .. v .. "/main.lua") then
            print("+ Found gamemode '" .. v .. "'")
            local gamemode = require("gamemode/" .. v .. "/main")
            GameManager.CustomGames[v] = gamemode
        end
    end

    local gamemode = Config.Get("gamemode")
    if gamemode then
        GameManager.CurrentGame = GameManager.CustomGames[gamemode]
        print("\n+ Gamemode set to '" .. gamemode .. "'")
    end

    if GameManager.CurrentGame then
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
