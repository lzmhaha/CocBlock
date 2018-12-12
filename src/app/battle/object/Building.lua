local Building = class('Building', require('app.battle.object.BaseObject'))

function Building:ctor()
    self.super.ctor(self)
    self.type = OBJECT_TYPE.BUILDING
end

return Building