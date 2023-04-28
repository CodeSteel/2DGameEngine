local Gamemode = {}
Gamemode.Name = "Example: Getting Started"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true

function Gamemode.Load()
    Gamemode.ply = CreateObject(Vector(100, 100))
    Gamemode.ply:SetSize(20, 20)
    Gamemode.ply:SetColor(color_green)
    Gamemode.ply:SetStyle(DRAW_STYLE_RECT)
    Gamemode.ply:SetupPhys(1, false, 1)
    Gamemode.ply:Spawn()
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
        bullet:SetColor(color_red)
        bullet:SetStyle(DRAW_STYLE_CIRCLE)
        bullet:SetupPhys(100, false, 1)
        bullet:Spawn()





        -- apply force
        bullet:ApplyForce(dir.x * 100, dir.y * 100)
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
    Gamemode.ply.x = math.Clamp(Gamemode.ply.x, 0, GameManager.CurrentGame.WindowWidth - Gamemode.ply.w)
    Gamemode.ply.y = math.Clamp(Gamemode.ply.y, 0, GameManager.CurrentGame.WindowHeight - Gamemode.ply.h)
end

return Gamemode
