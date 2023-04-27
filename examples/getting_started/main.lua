local Gamemode = {}
Gamemode.Name = "Call of Duty 4: Modern Warfare"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true

function Gamemode.Load()
    Gamemode.ply = CreateObject(100, 100)
    Gamemode.ply:SetSize(20, 20)
    Gamemode.ply:SetColor(color_green)
    Gamemode.ply:SetStyle(DRAW_STYLE_RECT)
    Gamemode.ply:SetupPhys(1, false, 1)
    Gamemode.ply:Spawn()
end

function Gamemode.Update()
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
