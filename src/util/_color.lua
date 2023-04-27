local color = {}
color.__index = color

function color:__tostring()
    return string.format("Color(%d, %d, %d, %d)", self.r, self.g, self.b, self.a)
end

function color:Set()
    love.graphics.setColor(self.r, self.g, self.b, self.a)
end

function color:Clone()
    return Color(self.r, self.g, self.b, self.a)
end

function _G.Color(r, g, b, a)
    local col = setmetatable({}, color)
    col.r = r or 0
    col.g = g or 0
    col.b = b or 0
    col.a = a or 255
    return col
end

function _G.RandomColor()
    local randomR = math.random(0, 255)
    local randomG = math.random(0, 255)
    local randomB = math.random(0, 255)
    return Color(randomR, randomG, randomB)
end

_G.color_white = Color(255, 255, 255)
_G.color_black = Color(0, 0, 0)
_G.color_red = Color(255, 0, 0)
_G.color_green = Color(0, 255, 0)
_G.color_blue = Color(0, 0, 255)
_G.color_yellow = Color(255, 255, 0)
_G.color_purple = Color(255, 0, 255)
_G.color_cyan = Color(0, 255, 255)
_G.color_orange = Color(255, 128, 0)
_G.color_pink = Color(255, 0, 128)
