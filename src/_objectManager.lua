local ObjectManager = {}
ObjectManager.Objects = {}

local indexCount = 0

function ObjectManager.Register(object)
    indexCount = indexCount + 1
    object.index = indexCount
    ObjectManager.Objects[indexCount] = object
end

function ObjectManager.Unregister(object)
    ObjectManager.Objects[object.index] = nil
end

function ObjectManager.Update()
    for i, object in pairs(ObjectManager.Objects) do
        object:Update()
    end
end

function ObjectManager.Draw()
    for i, object in pairs(ObjectManager.Objects) do
        object:Draw()
    end
end

function ObjectManager.Clear()
    ObjectManager.Objects = {}
end

_G.IsValid = function(object)
    return object and object.index and ObjectManager.Objects[object.index] == object
end

_G.ObjectManager = ObjectManager
