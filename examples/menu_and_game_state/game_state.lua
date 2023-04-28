local GameState = CreateNewState()

function GameState:Enter()
    print("\n+ Game State Entered!")

    GameManager.CurrentGame.TimeStart = CurTime()

    self.ply = CreateObject(Vector(100, 100))
    self.ply:SetSize(20, 20)
    self.ply:SetColor(color_green)
    self.ply:SetStyle(DRAW_STYLE_CIRCLE)
    self.ply:SetupPhys(1, false, 1)
    self.ply:Spawn()

    self.enemies = {}
    for i = 1, GameManager.CurrentGame.EnemyCount do
        local enemy = CreateObject(Vector(math.random(0, ScrW()), math.random(0, ScrH())))
        enemy:SetSize(10, 10)
        enemy:SetColor(color_red)
        enemy:SetStyle(DRAW_STYLE_RECT)
        enemy:SetupPhys(1, false, 1)
        function enemy.OnCollision(s, other)
            if other.index == self.ply.index then
                enemy:Destroy()
                GameManager.CurrentGame.Score = GameManager.CurrentGame.Score + 1
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
        local randomX = math.random(-1, 1) / 10
        local randomY = math.random(-1, 1) / 10

        enemy:ApplyForce(randomX, randomY)

        enemy.x = math.Clamp(enemy.x, 0, ScrW() - enemy.w)
        enemy.y = math.Clamp(enemy.y, 0, ScrH() - enemy.h)
    end

    -- add player's velocity
    self.ply:ApplyForce(wishDir.x, wishDir.y)

    -- clamp player position to window
    self.ply.x = math.Clamp(self.ply.x, 0, ScrW() - self.ply.w)
    self.ply.y = math.Clamp(self.ply.y, 0, ScrH() - self.ply.h)
end

function GameState:Draw()
    Draw.SimpleText("FPS: " .. Time.FPS, "UIMedium", ScrW() - 10, 15, Color(100, 100, 100),
        TEXT_ALIGN_RIGHT, 500)

    Draw.SimpleText("Score: " .. GameManager.CurrentGame.Score, "UIMedium", ScrW() - 10, 50, color_white,
        TEXT_ALIGN_RIGHT, 500)

    Draw.SimpleText("Time: " .. math.round(GameManager.CurrentGame.TimeElapsed), "UIMedium", ScrW() - 10, 85, color_white,
        TEXT_ALIGN_RIGHT, 500)
end

function GameState:Exit()
    if (IsValid(self.ply)) then
        self.ply:Destroy()
    end

    if (self.enemies) then
        for _, enemy in ipairs(self.enemies) do
            if (IsValid(enemy)) then
                enemy:Destroy()
            end
        end
    end
end

return GameState
