
local BattleCamera = class('BattleCamera', function()
    return cc.Camera:create()
end)

function BattleCamera:ctor()
    self:align(display.CENTER)
    self:size(display.size)
    self:setCameraFlag(CAMERA_FRAG_BATTLE)
end

return BattleCamera