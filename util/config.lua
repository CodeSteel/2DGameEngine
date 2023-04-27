local Config = {}
Config.values = {}
Config.__index = Config

function Config.Load()
    if not love.filesystem.getInfo("config.json") then
        love.filesystem.write("config.json", "{}")
    end

    local config = love.filesystem.read("config.json")
    Config.values = json.decode(config)

    print("\n+ Config loaded!")
end

function Config.Get(key)
    return Config.values[key]
end

function Config.Set(key, value)
    Config.values[key] = value
    love.filesystem.write("config.json", json.encode(Config.values))
end

_G.Config = Config
