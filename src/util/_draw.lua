local Draw = {}
Draw.__index = Draw

function Draw.RoundedBox(roundness, x, y, w, h, col)
    col:Set()

    love.graphics.arc("fill", x + roundness, y + roundness, roundness, math.pi, 3 * math.pi / 2)
    love.graphics.arc("fill", x + w - roundness, y + roundness, roundness, 3 * math.pi / 2, 2 * math.pi)
    love.graphics.arc("fill", x + w - roundness, y + h - roundness, roundness, 0, math.pi / 2)
    love.graphics.arc("fill", x + roundness, y + h - roundness, roundness, math.pi / 2, math.pi)
    -- Draw the connecting rectangles
    love.graphics.rectangle("fill", x + roundness, y, w - 2 * roundness, h)
    love.graphics.rectangle("fill", x, y + roundness, w, h - 2 * roundness)
end

function Draw.SimpleText(text, font, x, y, col, align, limit)
    if (isstring(font)) then
        Font.GetFont(font):Set()
    else
        font:Set()
    end

    local width = Font.GetTextSize(text, font)

    if (align == TEXT_ALIGN_RIGHT) then
        x = x - width
    end

    if (align == TEXT_ALIGN_CENTER) then
        x = x - width / 2
    end

    col:Set()
    love.graphics.printf(text, x, y, limit)
end

function Draw.DrawCircle(x, y, radius, col)
    col:Set()
    love.graphics.circle('fill', x, y, radius)
end

function Draw.DrawPoly(points, col)
    col:Set()
    love.graphics.polygon('fill', points)
end

function Draw.DrawTriangle(x1, y1, x2, y2, x3, y3, col)
    col:Set()
    love.graphics.polygon('fill', x1, y1, x2, y2, x3, y3)
end

_G.Draw = Draw

_G.TEXT_ALIGN_LEFT = 'left'
_G.TEXT_ALIGN_CENTER = 'center'
_G.TEXT_ALIGN_RIGHT = 'right'

function _G.ScrW()
    local w = love.window.getMode()
    return w
end

function _G.ScrH()
    local _, h = love.window.getMode()
    return h
end
