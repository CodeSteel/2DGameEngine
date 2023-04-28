local Gamemode = {}
Gamemode.Name = "Example: Menu and Game State"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true
Gamemode.BackgroundColor = color_black

Gamemode.EnemyCount = 5
Gamemode.Score = 0
Gamemode.TimeElapsed = 0
Gamemode.Finished = false
Gamemode.TimeStart = 0

Sound.Create("MenuMusic", "assets/sounds/menu_music.mp3")
Sound.Create("GameMusic", "assets/sounds/game_music.mp3")
Sound.Create("Bing", "assets/sounds/bing.mp3")

function Gamemode.Load()
    Game.StateMachine:Push(require('menu_state'))
end

function Gamemode.Update()
    if Gamemode.Score >= GameManager.CurrentGame.EnemyCount and not Gamemode.Finished then
        Gamemode.Finished = true
        Game.StateMachine:Change(require('win_menu_state'))
    elseif not Gamemode.Finished then
        Gamemode.TimeElapsed = CurTime() - Gamemode.TimeStart
    end
end

return Gamemode
