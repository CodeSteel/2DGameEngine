local State = {}
State.__index = State

function _G.CreateNewState()
    local state = {}
    setmetatable(state, State)
    return state
end

function State:Enter()

end

function State:Exit()

end

function State:Update()

end

function State:Draw()

end
