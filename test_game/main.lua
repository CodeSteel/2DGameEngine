local Gamemode = {}
Gamemode.Name = "Test"

function Gamemode.Load()
    print("\n+ Test Gamemode loaded!")

    local testObject = CreateObject(50, 400, false)
    testObject:SetSize(200, 50)
    testObject:SetColor(Color(255, 100, 0))
    testObject:Spawn()
end

function Gamemode.Update()

end

return Gamemode
