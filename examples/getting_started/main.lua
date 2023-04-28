local Gamemode = {}
Gamemode.Name = "Example: Getting Started"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true
Gamemode.BackgroundColor = color_black

function Gamemode.Load()
    Gamemode.ply = CreateObject(Vector(100, 100))
    Gamemode.ply:SetSize(50, 20)
    Gamemode.ply:SetColor(color_white)
    Gamemode.ply:SetTexture(CreateTexture("assets/icon.png"))
    Gamemode.ply:SetupPhys(1, false, 1)
    Gamemode.ply:Spawn()
    Gamemode.ply.body:setFixedRotation(true)
end

function Gamemode.Update()
    if (Input.GetMouseButtonDown(1)) then
        -- get mouse position
        local mouseX, mouseY = love.mouse.getPosition()
        local mousePos = Vector(mouseX, mouseY)
        local plyPos = Vector(Gamemode.ply.x, Gamemode.ply.y)

        -- get direction
        local dir = mousePos - plyPos
        dir = dir:normalized()

        local bulletSpawnPosition = plyPos + dir * 20

        -- spawn bullet
        local bullet = CreateObject(bulletSpawnPosition)
        bullet:SetSize(10, 10)
        bullet:SetColor(color_blue)
        bullet:SetStyle(DRAW_STYLE_CIRCLE)
        bullet:SetupPhys(100, false, 1)
        bullet:SetRemoveOnLeaveScreen(true)
        bullet:Spawn()

        -- apply force
        bullet:ApplyForce(dir.x * 100, dir.y * 100)

        TimerCreate("bullet_" .. bullet.index, 3, 1, function()
            if (not IsValid(bullet)) then return end
            bullet:Destroy()
        end)
    end

    local dt = Time.DeltaTime

    -- get veclocity
    local speed = 300 * 10
    local inputDir = Input.GetAxis()
    local wishDir = Vector(0, 0)

    wishDir = inputDir * speed * dt

    -- add friction
    Gamemode.ply.vX = Gamemode.ply.vX * (1 - math.min(dt * 4, 1))
    Gamemode.ply.vY = Gamemode.ply.vY * (1 - math.min(dt * 4, 1))

    -- add player's velocity
    Gamemode.ply:ApplyForce(wishDir.x, wishDir.y)

    -- clamp player position to window
    Gamemode.ply.x = math.Clamp(Gamemode.ply.x, 0, ScrW() - Gamemode.ply.w)
    Gamemode.ply.y = math.Clamp(Gamemode.ply.y, 0, ScrH() - Gamemode.ply.h)
end

return Gamemode
