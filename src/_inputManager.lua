local InputManager = {}
InputManager.__index = InputManager

function InputManager:Update()
    self.previousState = self.state
end

function InputManager:KeyPressed(key, unicode)
    self.state[key] = true
end

function InputManager:KeyReleased(key, unicode)
    self.state[key] = false
end

function InputManager:GetKeyDown(key)
    return self.state[key] and not self.previousState[key]
end

function InputManager:GetKey(key)
    return self.state[key] or false
end

_G.CreateInputManager = function()
    local _inputManager = {}
    setmetatable(_inputManager, InputManager)

    _inputManager.previousState = {}
    _inputManager.state = {}

    return _inputManager
end
