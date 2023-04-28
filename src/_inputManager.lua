local InputManager = {}
InputManager.__index = InputManager

function InputManager:GetKeyDown(key)
    return self.state.keys[key] and not self.previousState[key]
end

function InputManager:GetKey(key)
    return self.state.keys[key] or false
end

function InputManager:GetMousePosition()
    return Vector(self.state.mouseX, self.state.mouseY)
end

function InputManager:GetMouseDelta()
    return Vector(self.state.mouseDX, self.state.mouseDY)
end

function InputManager:GetMouseWheel()
    return Vector(self.state.mouseWheelX, self.state.mouseWheelY)
end

function InputManager:GetMouseButton(btn)
    return self.state.mouse[btn]
end

function InputManager:GetMouseButtonDown(btn)
    return self.state.mouse[btn] and not self.previousState.mouse[btn]
end

function InputManager:Update()
    self.previousState = table.Copy(self.state)
end

function InputManager:KeyPressed(key, unicode)
    self.state.keys[key] = true
end

function InputManager:KeyReleased(key, unicode)
    self.state.keys[key] = false
end

function InputManager:MouseMoved(x, y, dx, dy, isTouch)
    self.state.mouseX = x
    self.state.mouseY = y
    self.state.mouseDX = dx
    self.state.mouseDY = dy
    self.state.mouseIsTouch = isTouch
end

function InputManager:MousePressed(x, y, button, isTouch, presses)
    self.state.mouseX = x
    self.state.mouseY = y
    self.state.mouseIsTouch = isTouch
    self.state.mousePresses = presses
    self.state.mouse[button] = true
end

function InputManager:MouseReleased(x, y, button, isTouch, presses)
    self.state.mouseX = x
    self.state.mouseY = y
    self.state.mouseIsTouch = isTouch
    self.state.mousePresses = presses
    self.state.mouse[button] = false
end

function InputManager:WheelMoved(x, y)
    self.state.mouseWheelX = x
    self.state.mouseWheelY = y
end

_G.CreateInputManager = function()
    local _inputManager = {}
    setmetatable(_inputManager, InputManager)

    _inputManager.previousState = {}
    _inputManager.state = {}
    _inputManager.state.mouse = {}
    _inputManager.state.keys = {}

    return _inputManager
end
