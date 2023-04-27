local stateMachine = {}
stateMachine.__index = stateMachine

function _G.CreateStateMachine()
    local _stateMachine = {
        stack = {}
    }
    setmetatable(_stateMachine, stateMachine)
    return _stateMachine
end

function stateMachine:Push(state)
    table.insert(self.stack, state)
    state:Enter()
end

function stateMachine:Pop()
    local state = table.remove(self.stack)
    state:Exit()
end

function stateMachine:Change(state)
    self:Pop()
    self:Push(state)
end

function stateMachine:Update()
    local currentState = self.stack[#self.stack]
    currentState:Update()
end

function stateMachine:Draw()
    local currentState = self.stack[#self.stack]
    currentState:Draw()
end
