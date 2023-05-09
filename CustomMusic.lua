local music = CreateFrame("Frame", nil, UIParent)
local media = "Interface\\Addons\\CustomMusic\\media\\"
local playing

function music:zoneUpdate()
    local subzone = GetSubZoneText()
    if music.subzone ~= subzone then
        music.subzone = subzone
    end

    local zone = GetRealZoneText()
    if music.zone ~= zone then
        music.zone = zone
    end    
end

local subzones = {
    -- ["Valley of Strength"] = {["music"] = "undercity.mp3"}, -- Example
    ["Valley of Strength"] = {["music"] = "undercity.mp3"},
    ["Stoutlager Inn"] = {["music"] = "tinkertown.mp3"},    
}

local zones = {
    -- ["Orgrimmar"] = {["music"] = "tinkertown.mp3"}, -- Example
    ["Orgrimmar"] = {["music"] = "tinkertown.mp3"},
}

function music:playCustom(subzone, zone)
    -- PlayMusic() replaces the in-game music and plays whatever you give it in a loop. 
    -- You can use StopMusic() to have the game resume playing its own.

    if subzones[subzone] then
        playing = true
        PlayMusic(media..subzones[subzone]["music"])
        return
    elseif zones[zone] then
        playing = true
        PlayMusic(media..zones[zone]["music"])
        return
    else
        if playing then
            playing = nil
            StopMusic()
        end
    end
end

music:RegisterEvent("MINIMAP_ZONE_CHANGED")

music:SetScript("OnEvent", function()
    music:zoneUpdate()
    music:playCustom(music.subzone, music.zone)
end)

DEFAULT_CHAT_FRAME:AddMessage("CustomMusic Loaded!")