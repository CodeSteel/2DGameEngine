local Gamemode = {}
Gamemode.Name = "Call of Duty 4: Modern Warfare"

require('states')

function Gamemode.Load()
    Game.StateMachine:Push(MenuState)
end

function Gamemode.Update()
end

_G.Gamemode = Gamemode
return Gamemode
