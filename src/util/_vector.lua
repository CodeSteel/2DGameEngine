local vector = {}
vector.__index = vector

function vector:__add(other)
    return _G.Vector(self.x + other.x, self.y + other.y, self.z + other.z)
end

function vector:__sub(other)
    return _G.Vector(self.x - other.x, self.y - other.y, self.z - other.z)
end

function vector:__mul(other)
    if (type(other) == "number") then
        return _G.Vector(self.x * other, self.y * other, self.z * other)
    end
    return _G.Vector(self.x * other.x, self.y * other.y, self.z * other.z)
end

function vector:__div(other)
    return _G.Vector(self.x / other.x, self.y / other.y, self.z / other.z)
end

function vector:__eq(other)
    return self.x == other.x and self.y == other.y and self.z == other.z
end

function vector:__tostring()
    return string.format("Vector(%s, %s, %s)", self.x, self.y, self.z)
end

function vector:__unm()
    return _G.Vector(-self.x, -self.y, -self.z)
end

function vector:__len()
    return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function vector:normalized()
    local len = #self
    return _G.Vector(self.x / len, self.y / len, self.z / len)
end

_G.Vector = function(x, y, z)
    local vec = {}
    setmetatable(vec, vector)

    vec.x = x or 0
    vec.y = y or 0
    vec.z = z or 0

    return vec
end
