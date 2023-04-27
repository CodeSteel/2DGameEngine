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
    if love.keyboard.isDown("up") then
        self.currentSelection = math.max(self.currentSelection - 1, 1)
    elseif love.keyboard.isDown("down") then
        self.currentSelection = math.min(self.currentSelection + 1, #self.menu)
    end

    if love.keyboard.isDown("return") then
        self.menu[self.currentSelection].action()
    end
end

function MenuState:Draw()
    color_green:set()

    love.graphics.print(Gamemode.Name, 100, 100)

    for i, item in ipairs(self.menu) do
        local x = 100
        local y = 150 + (i - 1) * 50

        if i == self.currentSelection then
            color_red:set()
        else
            color_white:set()
        end
        love.graphics.print(item.label, x, y)
    end
end

_G.MenuState = MenuState

local GameState = CreateNewState()

function GameState:Enter()
    print("\n+ Game State Entered!")

    self.player = { x = 100, y = 100, vx = 0, vy = 0 }
    self.enemies = {}
    for i = 1, 10 do
        table.insert(self.enemies, { x = math.random(0, 800), y = math.random(0, 600), vx = 0, vy = 0 })
    end
end

function GameState:Update()
    local dt = Game.FrameTime

    if love.keyboard.isDown("up") then
        self.player.vy = self.player.vy - 100 * dt * 2
    elseif love.keyboard.isDown("down") then
        self.player.vy = self.player.vy + 100 * dt * 2
    end
    if love.keyboard.isDown("left") then
        self.player.vx = self.player.vx - 100 * dt * 2
    elseif love.keyboard.isDown("right") then
        self.player.vx = self.player.vx + 100 * dt * 2
    end

    for _, enemy in ipairs(self.enemies) do
        enemy.vx = math.random(-50, 50)
        enemy.vy = math.random(-50, 50)
        enemy.x = enemy.x + enemy.vx * dt
        enemy.y = enemy.y + enemy.vy * dt
    end

    self.player.x = self.player.x + self.player.vx * dt * 10
    self.player.y = self.player.y + self.player.vy * dt * 10

    self.player.x = math.max(0, math.min(love.graphics.getWidth(), self.player.x))
    self.player.y = math.max(0, math.min(love.graphics.getHeight(), self.player.y))
end

function GameState:Draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", self.player.x, self.player.y, 20)

    love.graphics.setColor(1, 0, 0)
    for _, enemy in ipairs(self.enemies) do
        love.graphics.circle("fill", enemy.x, enemy.y, 10)
    end
end

_G.GameState = GameState
