local Gamemode = {}
Gamemode.Name = "Example: Platformer"
Gamemode.WindowWidth = 1250
Gamemode.WindowHeight = 720
Gamemode.WindowResizable = true
Gamemode.BackgroundColor = Color(50, 50, 50)

function Gamemode.Load()
    Gamemode.ply = CreateObject(Vector(100, 100))
    Gamemode.ply:SetSize(25, 25)
    Gamemode.ply:SetColor(Color(190, 50, 60))
    Gamemode.ply:SetStyle(DRAW_STYLE_RECT)
    Gamemode.ply:SetupPhysics(0.1, 1)
    Gamemode.ply:UseGravity(false)
    Gamemode.ply.body:setFixedRotation(true)
    Gamemode.ply:Spawn()

    local ground = CreateObject(Vector(-ScrW() / 2, ScrH() - 75), 'static')
    ground:SetSize(ScrW(), 50)
    ground:SetColor(Color(50, 220, 80))
    ground:SetStyle(DRAW_STYLE_RECT)
    ground:SetupPhysics(1000, 2)
    ground:Spawn()
end

function Gamemode.Update()
    local dt = Time.DeltaTime

    -- get veclocity
    local speed = 5000 * 10
    local inputDir = Input.GetAxis()
    local wishDir = Vector(0, 0)

    wishDir = inputDir * speed * dt

    -- add friction
    wishDir.x = wishDir.x * (1 - math.min(dt * 4, 1))
    wishDir.y = wishDir.y * (1 - math.min(dt * 4, 1))

    -- add player's velocity
    Gamemode.ply:ApplyForce(wishDir)

    -- add counter force to slow down player
    local vel = Gamemode.ply:GetVelocity()
    local counterForce = Vector(-vel.x, -vel.y)
    counterForce = counterForce * 0.1

    Gamemode.ply:ApplyForce(counterForce)

    -- clamp player position to window
    Gamemode.ply.x = math.Clamp(Gamemode.ply.x, 0, ScrW() - Gamemode.ply.w)
    Gamemode.ply.y = math.Clamp(Gamemode.ply.y, 0, ScrH() - Gamemode.ply.h)
end

return Gamemode
