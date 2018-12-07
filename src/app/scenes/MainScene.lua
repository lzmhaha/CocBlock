
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    display.newTTFLabel({text = "Hello, World", size = 64})
        :align(display.CENTER, display.cx, display.cy)
        :addTo(self)
end

function MainScene:onEnter()
    -- local node = require('util.creator').parseJson('creator/scenes/login.json')
    -- node:addTo(self)

    local prefab = require('util.creator').parseJson('creator/prefabs/block_white.json')
    prefab:center():addTo(self)
end

function MainScene:onExit()
end

return MainScene
