local GameState = CreateNewState()

function GameState:Enter()
    print("\n+ Game State Entered!")

    self.ply = CreateObject(Vector(100, 100))
    self.ply:SetSize(20, 20)
    self.ply:SetColor(color_green)
    self.ply:SetStyle(DRAW_STYLE_RECT)
    self.ply:SetupPhys(1, false, 1)
    self.ply:Spawn()

    self.enemies = {}
    for i = 1, 20 do
        local enemy = CreateObject(Vector(math.random(0, GameManager.CurrentGame.WindowWidth),
            math.random(0, GameManager.CurrentGame.WindowHeight)))
        enemy:SetSize(10, 10)
        enemy:SetColor(color_red)
        enemy:SetStyle(DRAW_STYLE_RECT)
        enemy:SetupPhys(1, false, 1)
        function enemy.OnCollision(other)
            if other.index == self.ply.index then
                enemy:Destroy()
            end
        end

        enemy:Spawn()

        table.insert(self.enemies, enemy)
    end
end

function GameState:Update()
    local dt = Time.DeltaTime

    -- get veclocity
    local speed = 300 * 10
    local inputDir = Input.GetAxis()
    local wishDir = Vector(0, 0)

    wishDir = inputDir * speed * dt

    -- add friction
    self.ply.vX = self.ply.vX * (1 - math.min(dt * 4, 1))
    self.ply.vY = self.ply.vY * (1 - math.min(dt * 4, 1))

    -- move enemies
    for _, enemy in ipairs(self.enemies) do
        enemy:ApplyForce(math.random(-10, 10), math.random(-10, 10))

        enemy.x = math.Clamp(enemy.x, 0, GameManager.CurrentGame.WindowWidth - enemy.w)
        enemy.y = math.Clamp(enemy.y, 0, GameManager.CurrentGame.WindowHeight - enemy.h)
    end

    -- add player's velocity
    self.ply:ApplyForce(wishDir.x, wishDir.y)

    -- clamp player position to window
    self.ply.x = math.Clamp(self.ply.x, 0, GameManager.CurrentGame.WindowWidth - self.ply.w)
    self.ply.y = math.Clamp(self.ply.y, 0, GameManager.CurrentGame.WindowHeight - self.ply.h)
end

function GameState:Draw()

end

local MenuState = CreateNewState()

function MenuState:Enter()
    print("\n+ Menu State Entered!")

    self.menu = {
        { label = "Play", action = function() Game.StateMachine:Change(GameState) end },
        { label = "Quit", action = function() love.event.quit() end }
    }

    self.currentSelection = 1
end

function MenuState:Update()
    if Input.GetKey("up") then
        self.currentSelection = math.max(self.currentSelection - 1, 1)
    elseif Input.GetKey("down") then
        self.currentSelection = math.min(self.currentSelection + 1, #self.menu)
    end

    if Input.GetKey("return") then
        self.menu[self.currentSelection].action()
    end
end

function MenuState:Draw()
    color_green:Set()

    love.graphics.print(GameManager.CurrentGame.Name, 100, 100)

    for i, item in ipairs(self.menu) do
        local x = 100
        local y = 150 + (i - 1) * 50

        if i == self.currentSelection then
            color_red:Set()
        else
            color_white:Set()
        end
        love.graphics.print(item.label, x, y)
    end
end

return MenuState
