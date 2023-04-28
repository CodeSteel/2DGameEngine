local Object = {}
Object.__index = Object

function Object:ApplyForce(x, y)
    self.vX = self.vX + x
    self.vY = self.vY + y
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

function Object:SetupPhys(mass, useGravity, colCategory, ignoreMask)
    colCategory = colCategory or 1
    useGravity = useGravity or false
    mass = mass or 1

    self.mass = mass
    self.useGravity = useGravity

    self.body = love.physics.newBody(Game.World, self.x, self.y, self.isStatic and "static" or "dynamic")
    self.shape = love.physics.newRectangleShape(self.w, self.h)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setUserData(self)
    self.body:setMass(mass)

    self.fixture:setCategory(colCategory)
    if ignoreMask then
        self.fixture:setMask(ignoreMask)
    end
end

function Object:Update()
    if not self.Active or not self.Spawned then return end

    -- update position to physics body
    self.body:setPosition(self.x + self.vX * Time.DeltaTime, self.y + self.vY * Time.DeltaTime)
    self.x, self.y = self.body:getPosition()

    -- gravity
    if not self.isStatic and self.useGravity then
        local gravityY = 9.81 * self.mass
        self:ApplyForce(0, gravityY)
    end

    -- destroy if off screen
    if (self.removeOnLeaveScreen) then
        if (self.x < 0 or self.x > ScrW() or self.y < 0 or self.y > ScrH()) then
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
        love.graphics.draw(self.texture, self.quad, self.x, self.y, self.rotation, 1, 1)
    else
        love.graphics.push()

        love.graphics.translate(self.x, self.y)
        love.graphics.rotate(self.body:getAngle())

        if (self.style == DRAW_STYLE_CIRCLE) then
            love.graphics.circle(self.fillmode == DRAW_FILLMODE_FILL and "fill" or "line", 0, 0, self.w)
        elseif (self.style == DRAW_STYLE_TRI) then
            love.graphics.polygon(self.fillmode == DRAW_FILLMODE_FILL and "fill" or "line", 0, 0, self.w, 0, self.w / 2,
                self.h)
        else
            love.graphics.rectangle(self.fillmode == DRAW_FILLMODE_FILL and "fill" or "line", 0, 0, self.w, self.h)
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

    ObjectManager.Unregister(self)
end

-- Create a new Object and register it to the ObjectManager
function _G.CreateObject(position, isStatic)
    local object = {}
    setmetatable(object, Object)

    object.x = position.x
    object.y = position.y
    object.vX = 0
    object.vY = 0
    object.rotation = 0
    object.isStatic = isStatic
    object.fillmode = DRAW_FILLMODE_FILL
    object.style = DRAW_STYLE_RECT

    ObjectManager.Register(object)

    return object
end

_G.DRAW_STYLE_RECT = 1
_G.DRAW_STYLE_CIRCLE = 2
_G.DRAW_STYLE_TRI = 3

_G.DRAW_FILLMODE_FILL = 1
_G.DRAW_FILLMODE_LINE = 2
