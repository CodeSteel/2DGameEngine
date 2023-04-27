local Gamemode = {}
Gamemode.Name = "Call of Duty 4: Modern Warfare"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true

require('states')

function Gamemode.Load()
    Game.StateMachine:Push(MenuState)
end

function Gamemode.Update()
end

_G.Gamemode = Gamemode
return Gamemode
