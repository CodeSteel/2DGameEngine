local ObjectManager = {}
ObjectManager.Objects = {}

function ObjectManager.Register(object)
    local index = #ObjectManager.Objects + 1
    object.index = index
    ObjectManager.Objects[index] = object
end

function ObjectManager.Unregister(object)
    ObjectManager.Objects[object.index] = nil
end

function ObjectManager.Update()
    for i, object in ipairs(ObjectManager.Objects) do
        object:Update()
    end
end

function ObjectManager.Draw()
    for i, object in ipairs(ObjectManager.Objects) do
        object:Draw()
    end
end

function ObjectManager.Clear()
    ObjectManager.Objects = {}
end

_G.ObjectManager = ObjectManager
