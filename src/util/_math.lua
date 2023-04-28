function math.Clamp(x, min, max)
    return x < min and min or (x > max and max or x)
end

function math.round(x)
    return x % 1 >= 0.5 and math.ceil(x) or math.floor(x)
end
