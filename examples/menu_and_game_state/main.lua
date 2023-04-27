local Gamemode = {}
Gamemode.Name = "Call of Duty 4: Modern Warfare"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true

local menuState = require('states')

function Gamemode.Load()
    Game.StateMachine:Push(menuState)
end

function Gamemode.Update()
end

return Gamemode
