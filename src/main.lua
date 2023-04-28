require('_modules')

_G.love = love

function love.load()
    math.randomseed(os.time(), os.clock())

    Game.FontLibrary = CreateFontLibrary()
    Font.CreateFont("UILarge", "engineassets/fonts/SourceSansPro-Regular.ttf", 32)
    Font.CreateFont("UIMedium", "engineassets/fonts/SourceSansPro-Regular.ttf", 24)
    Font.CreateFont("UISmall", "engineassets/fonts/SourceSansPro-Regular.ttf", 18)

    Font.CreateFont("UILargeB", "engineassets/fonts/SourceSansPro-Bold.ttf", 32)
    Font.CreateFont("UIMediumB", "engineassets/fonts/SourceSansPro-Bold.ttf", 24)
    Font.CreateFont("UISmallB", "engineassets/fonts/SourceSansPro-Bold.ttf", 18)

    Game.SoundLibrary = CreateSoundLibrary()
    Game.StateMachine = CreateStateMachine()
    Game.InputManager = CreateInputManager()
    Game.Start()
    GameManager.Load()
end

-- 1. Update Time
-- 2. Update BaseGame
-- 3. Update GameManager (CurrentGame)
-- 4. Update Input
-- 5. Update ObjectManager (Objects)
-- 6. Update StateMachine (CurrentState)
function love.update(dt)
    Time.Update()
    Game.Update()
    GameManager.Update()
    Game.InputManager:Update()
    ObjectManager.Update()
    Game.StateMachine:Update()
end

function love.keypressed(key, unicode)
    Game.InputManager:KeyPressed(key, unicode)
end

function love.keyreleased(key, unicode)
    Game.InputManager:KeyReleased(key, unicode)
end

function love.mousemoved(x, y, dx, dy, isTouch)
    Game.InputManager:MouseMoved(x, y, dx, dy, isTouch)
end

function love.mousepressed(x, y, button, isTouch, presses)
    Game.InputManager:MousePressed(x, y, button, isTouch, presses)
end

function love.mousereleased(x, y, button, isTouch, presses)
    Game.InputManager:MouseReleased(x, y, button, isTouch, presses)
end

function love.wheelmoved(x, y)
    Game.InputManager:WheelMoved(x, y)
end

function love.draw()
    Game.Draw()
    GameManager.Draw()
    ObjectManager.Draw()
    Game.StateMachine:Draw()
end
