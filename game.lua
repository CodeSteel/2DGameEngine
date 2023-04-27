local Game = {}
Game.FrameTime = 0

function Game.Start()
    print("\n+ Game Started!")

    Game.World = love.physics.newWorld(0, 9.81 * 40, true)
end

function Game.Update()

end

function Game.Draw()

end

_G.Game = Game
