local Object = {}
Object.__index = Object

function Object:Update()
    if not self.Active then return end
    if not self.Spawned then return end

    self.x, self.y = self.body:getPosition()

    if self.OnUpdate then
        self:OnUpdate()
    end
end

function Object:SetColor(color)
    self.color = color
end

function Object:SetSize(w, h)
    self.w = w
    self.h = h
end

function Object:Draw()
    if not self.Active then return end
    if not self.Spawned then return end

    self.color:set()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

function Object:Spawn()
    self.body = love.physics.newBody(Game.World, self.x, self.y, self.isStatic and "static" or "dynamic")
    self.Spawned = true
    self.Active = true
end

-- Create a new Object and register it to the ObjectManager
function _G.CreateObject(x, y, isStatic)
    local object = {}
    setmetatable(object, Object)

    object.x = x
    object.y = y
    object.isStatic = isStatic

    ObjectManager.Register(object)

    return object
end
