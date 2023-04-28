local SoundLibrary = {}
SoundLibrary.__index = SoundLibrary
SoundLibrary.Sounds = {}

function SoundLibrary:RegisterSound(sound)
    self.Sounds[sound.name] = sound
end

function SoundLibrary:GetSound(name)
    return self.Sounds[name]
end

function SoundLibrary:RemoveSound(name)
    self.Sounds[name] = nil
end

function _G.CreateSoundLibrary()
    local _soundLibrary = {}
    setmetatable(_soundLibrary, SoundLibrary)

    return _soundLibrary
end

local sound = {}
sound.__index = sound

function sound:Play()
    love.audio.play(self.sound)
end

function sound:SetLooping(loop)
    self.sound:setLooping(loop)
end

function sound:SetVolume(volume)
    self.sound:setVolume(volume)
end

function sound:SetPitch(pitch)
    self.sound:setPitch(pitch)
end

function sound:Stop()
    love.audio.stop(self.sound)
end

local Sound = {}
Sound.__index = Sound

function Sound.Create(name, soundFile)
    local _sound = {}
    setmetatable(_sound, sound)

    _sound.sound = love.audio.newSource(soundFile, "static")
    _sound.name = name

    Game.SoundLibrary:RegisterSound(_sound)

    return _sound
end

function Sound.GetSound(sound)
    return Game.SoundLibrary:GetSound(sound)
end

_G.Sound = Sound
