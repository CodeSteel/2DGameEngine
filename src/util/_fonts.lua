local FontLibrary = {}
FontLibrary.__index = FontLibrary
FontLibrary.Fonts = {}

function FontLibrary:RegisterFont(font)
    self.Fonts[font.name] = font
end

function FontLibrary:GetFont(name)
    return self.Fonts[name]
end

function FontLibrary:RemoveFont(name)
    self.Fonts[name] = nil
end

function _G.CreateFontLibrary()
    local _fontLibrary = {}
    setmetatable(_fontLibrary, FontLibrary)

    return _fontLibrary
end

local font = {}
font.__index = font

function font:Set()
    love.graphics.setFont(self.font)
end

local Font = {}
Font.__index = Font

function Font.CreateFont(name, fontFile, size)
    local _font = {}
    setmetatable(_font, font)

    _font.font = love.graphics.newFont(fontFile, size)
    _font.name = name

    Game.FontLibrary:RegisterFont(_font)

    return _font
end

function Font.GetFont(name)
    return Game.FontLibrary:GetFont(name)
end

function Font.GetTextSize(text, font)
    local _font = Game.FontLibrary:GetFont(font)
    return _font.font:getWidth(text), _font.font:getHeight()
end

_G.Font = Font
