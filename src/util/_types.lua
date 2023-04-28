_G.istable = function(t)
    return type(t) == "table"
end

_G.isnumber = function(t)
    return type(t) == "number"
end

_G.isstring = function(t)
    return type(t) == "string"
end

_G.isboolean = function(t)
    return type(t) == "boolean"
end

_G.iscolor = function(t)
    return type(t) == "userdata" and t.type == "Color"
end

_G.isvector = function(t)
    return type(t) == "userdata" and t.type == "Vector"
end
