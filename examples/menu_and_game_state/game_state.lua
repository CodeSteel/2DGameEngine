local GameState = CreateNewState()

function GameState:Enter()
    print("\n+ Game State Entered!")

    GameManager.CurrentGame.TimeStart = CurTime()

    self.ply = CreateObject(Vector(100, 100), "dynamic")
    self.ply:SetSize(20, 20)
    self.ply:SetColor(color_green)
    self.ply:SetStyle(DRAW_STYLE_CIRCLE)
    self.ply:SetupPhysics(0)
    self.ply:SetContinuousCollision(true)
    self.ply:UseGravity(false)
    self.ply:Spawn()

    self.enemies = {}
    for i = 1, GameManager.CurrentGame.EnemyCount do
        local enemy = CreateObject(Vector(math.random(0, ScrW()), math.random(0, ScrH())), "kinematic")
        enemy:SetSize(10, 10)
        enemy:SetColor(color_red)
        enemy:SetStyle(DRAW_STYLE_RECT)
        enemy:SetupPhysics(0)
        function enemy.OnCollision(s, other)
            if other.index == self.ply.index then
                enemy:Destroy()
                GameManager.CurrentGame.Score = GameManager.CurrentGame.Score + 1
                local sound = Sound.GetSound("Bing")
                sound:SetVolume(0.02)
                sound:SetPitch(math.random(0.5, 1.2))
                sound:Play()
            end
        end

        enemy:Spawn()

        table.insert(self.enemies, enemy)
    end

    self.Music = Sound.GetSound("GameMusic")
    self.Music:SetLooping(true)
    self.Music:SetVolume(0.01)
    self.Music:Play()
end

function GameState:Update()
    local dt = Time.DeltaTime

    -- get veclocity
    local speed = 50 * 10
    local inputDir = Input.GetAxis()
    local wishDir = Vector(0, 0)

    wishDir = inputDir * speed * dt

    -- add friction
    wishDir.x = wishDir.x * (1 - math.min(dt * 4, 1))
    wishDir.y = wishDir.y * (1 - math.min(dt * 4, 1))

    -- move enemies
    for _, enemy in ipairs(self.enemies) do
        local randomX = math.random(-1, 1) / 10
        local randomY = math.random(-1, 1) / 10

        if (not IsValid(enemy)) then goto continue end

        enemy:ApplyForce(Vector(randomX, randomY))

        enemy.x = math.Clamp(enemy.x, 0, ScrW() - enemy.w)
        enemy.y = math.Clamp(enemy.y, 0, ScrH() - enemy.h)
        ::continue::
    end

    -- update player's position
    self.ply:SetPosition(Vector(self.ply.x + wishDir.x, self.ply.y + wishDir.y))

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
    self.Music:Stop()

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
