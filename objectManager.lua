local ObjectManager = {}
ObjectManager.Objects = {}

function ObjectManager.Register(object)
    table.insert(ObjectManager.Objects, object)
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
