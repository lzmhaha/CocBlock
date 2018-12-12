OBJECT_GLOBLE_ID = 1
OBJECT_TYPE = {
    NONE = 'NONE',
    BUILDING = "BUILING",
    ACTOR = 'ACTOR',
}

local BaseObject = class('BaseObject', function()
    return display.newNode()
end)

function BaseObject:ctor()
    self.type = OBJECT_TYPE.NONE
    self.id = OBJECT_GLOBLE_ID
    OBJECT_GLOBLE_ID = OBJECT_GLOBLE_ID + 1
    self:setNodeEventEnabled(true)
    self:setCameraMask(CAMERA_FRAG_BATTLE)
end

return BaseObject