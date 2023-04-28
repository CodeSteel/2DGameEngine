local Input = {}
Input.__index = Input

-- Keyboard functions

function Input.GetVerticalAxis()
    local up = Input.GetKey("w") or Input.GetKey("up")
    local down = Input.GetKey("s") or Input.GetKey("down")

    if (up and down) then
        return 0
    elseif (up) then
        return -1
    elseif (down) then
        return 1
    else
        return 0
    end
end

function Input.GetHorizontalAxis()
    local left = Input.GetKey("a") or Input.GetKey("left")
    local right = Input.GetKey("d") or Input.GetKey("right")

    if (left and right) then
        return 0
    elseif (left) then
        return -1
    elseif (right) then
        return 1
    else
        return 0
    end
end

function Input.GetAxis()
    return Vector(Input.GetHorizontalAxis(), Input.GetVerticalAxis())
end

function Input.GetKeyDown(key)
    return Game.InputManager:GetKeyDown(key)
end

function Input.GetKey(key)
    return Game.InputManager:GetKey(key)
end

-- Mouse Functions

function Input.GetMouseButtonDown(btn)
    return Game.InputManager:GetMouseButtonDown(btn)
end

function Input.GetMouseButton(btn)
    return Game.InputManager:GetMouseButton(btn)
end

_G.Input = Input
