
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    self.uiLayer = display.newNode():size(display.size):addTo(self)
    self.battleLayer = display.newNode():addTo(self):pos(0, 0)
    :setCameraMask(CAMERA_FRAG_BATTLE)
end

function MainScene:onEnter()
    local map = require('app.battle.BattleMap').new('map.tmx')
    local size = map:getContentSize()
    map:addTo(self.battleLayer)

    local layer = map:getLayer('floor')
    layer:setTileGID(5, cc.p(0, 0))
    layer:setTileGID(6, cc.p(1, 0))

    local camera = require('app.battle.BattleCamera').new()
    camera:addTo(self.battleLayer)
    camera:setPosition(map:getCenterPos())
    camera:scale(5):scaleTo(1, 1)
    self.battleCamera = camera

end

function MainScene:onExit()
end

return MainScene
