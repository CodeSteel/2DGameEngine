require('_modules')

_G.love = love

function love.load()
    Game.StateMachine = CreateStateMachine()
    Game.Start()
    GameManager.Load()
end

function love.update(dt)
    Game.FrameTime = dt
    Game.Update()
    GameManager.Update()
    ObjectManager.Update()
    Game.StateMachine:Update()
end

function love.draw()
    Game.Draw()
    ObjectManager.Draw()
    Game.StateMachine:Draw()
end
