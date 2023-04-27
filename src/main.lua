require('_modules')

_G.love = love

function love.load()
    math.randomseed(os.time(), os.clock())

    Game.StateMachine = CreateStateMachine()
    Game.InputManager = CreateInputManager()
    Game.Start()
    GameManager.Load()
end

function love.update(dt)
    Time.Update()
    Game.InputManager:Update()
    Game.Update()
    GameManager.Update()
    ObjectManager.Update()
    Game.StateMachine:Update()
end

function love.keypressed(key, unicode)
    Game.InputManager:KeyPressed(key, unicode)
end

function love.keyreleased(key, unicode)
    Game.InputManager:KeyReleased(key, unicode)
end

function love.draw()
    Game.Draw()
    ObjectManager.Draw()
    Game.StateMachine:Draw()
end
