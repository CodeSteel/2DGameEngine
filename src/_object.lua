local Object = {}
Object.__index = Object

function Object:_eq(other)
    return self.index == other.index
end

function Object:ApplyForce(dir)
    self.body:applyForce(dir.x, dir.y)
end

function Object:ApplyImpulse(dir)
    self.body:applyImpulse(dir.x, dir.y)
end

function Object:ApplyTorque(torque)
    self.body:applyTorque(torque)
end

function Object:ApplyAngularImpulse(impulse)
    self.body:applyAngularImpulse(impulse)
end

function Object:ApplyLinearImpulse(dir)
    self.body:applyLinearImpulse(dir.x, dir.y)
end

function Object:SetPosition(position)
    self.body:setPosition(position.x, position.y)
end

function Object:GetPosition()
    return Vector(self.x, self.y)
end

function Object:GetVelocity()
    return Vector(self.body:getLinearVelocity())
end

function Object:UseGravity(use)
    self.body:setGravityScale(use and 1 or 0)
end

function Object:SetColor(color)
    self.color = color
end

function Object:SetSize(w, h)
    self.w = w
    self.h = h
end

function Object:SetFillMode(fillmode)
    self.fillmode = fillmode
end

function Object:SetStyle(style)
    self.style = style
end

function Object:SetTexture(texture)
    self.texture = texture
    self.quad = love.graphics.newQuad(0, 0, self.w, self.h, texture:getWidth(), texture:getHeight())
end

function Object:SetRotation(degrees)
    self.body:setAngle(math.rad(degrees))
end

function Object:SetRemoveOnLeaveScreen(remove)
    self.removeOnLeaveScreen = remove
end

function Object:SetContinuousCollision(continuous)
    self.body:setBullet(continuous)
end

function Object:SetupPhysics(mass, category, mask)
    category = category or 1
    mask = mask or 1
    mass = mass or 1

    self.mass = mass


    self.body = love.physics.newBody(Game.World, self.x, self.y, self.type)
    self.body:setMass(mass)
    self.shape = love.physics.newRectangleShape(self.w, self.h, self.w, self.h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setCategory(category)
    -- self.fixture:setMask(mask)
    self.fixture:setUserData(self)
end

function Object:Update()
    if not self.Active or not self.Spawned then return end

    -- update position to physics body
    self.x, self.y = self.body:getPosition()
    self.rotation = self.body:getAngle()

    -- destroy if off screen
    if (self.removeOnLeaveScreen) then
        if (not Util.IsOnScreen(self)) then
            self:Destroy()
        end
    end

    -- on update callback
    if self.OnUpdate then
        self:OnUpdate()
    end
end

function Object:Draw()
    if not self.Active or not self.Spawned then return end

    self.color:Set()

    if self.texture then
        love.graphics.draw(self.texture, self.quad, self.x, self.x, self.rotation, 1, 1)
    else
        love.graphics.push()

        love.graphics.translate(self.x + self.w / 2, self.y + self.h / 2)
        love.graphics.rotate(self.body:getAngle())

        if (self.style == DRAW_STYLE_CIRCLE) then
            love.graphics.circle(self.fillmode == DRAW_FILLMODE_FILL and "fill" or "line", 0, 0, self.w)
        elseif (self.style == DRAW_STYLE_TRI) then
            love.graphics.polygon(self.fillmode == DRAW_FILLMODE_FILL and "fill" or "line", 0, 0, self.w, 0, self.w / 2,
                self.h)
        else
            love.graphics.rectangle(self.fillmode == DRAW_FILLMODE_FILL and "fill" or "line", 0, 0, self.w, self.h)

            -- debugging
            if (Game.Debugging) then
                love.graphics.setColor(1, 0, 0)
                love.graphics.polygon("line", self.shape:getPoints())

                love.graphics.setColor(0, 1, 0)
                love.graphics.circle("fill", 0, 0, 2)
            end
        end

        love.graphics.pop()
    end
end

function Object:Spawn()
    self.Spawned = true
    self.Active = true
end

function Object:OnCollision(otherObject)
    -- Callback when this object collides with another object
end

function Object:Destroy()
    self.Spawned = false
    self.Active = false

    if self.body then
        self.body:destroy()
    end

    if self.OnDestroy then
        self:OnDestroy()
    end

    ObjectManager.Unregister(self)
end

-- Create a new Object and register it to the ObjectManager
function _G.CreateObject(position, type)
    local object = {}
    setmetatable(object, Object)

    object.x = position.x
    object.y = position.y
    object.rotation = 0
    object.type = type or 'dynamic'
    object.fillmode = DRAW_FILLMODE_FILL
    object.style = DRAW_STYLE_RECT
    object.removeOnLeaveScreen = false

    ObjectManager.Register(object)

    return object
end

_G.DRAW_STYLE_RECT = 1
_G.DRAW_STYLE_CIRCLE = 2
_G.DRAW_STYLE_TRI = 3

_G.DRAW_FILLMODE_FILL = 1
_G.DRAW_FILLMODE_LINE = 2
