local Gamemode = {}

function Gamemode.Load()
    print("\n+ Test Gamemode loaded!")

    local testObject = CreateObject(50, 400, false)
    testObject:SetSize(200, 50)
    testObject:SetColor(Color(255, 100, 0))
    testObject:Spawn()
    testObject.body:setLinearVelocity(1000, 0)
end

function Gamemode.Update()

end

return Gamemode
