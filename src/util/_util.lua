local Util = {}
Util.__index = Util

function Util.IsOnScreen(object)
    if (object.x < 0 or object.x > ScrW() or object.y < 0 or object.y > ScrH()) then
        return false
    end
    return true
end

_G.Util = Util
