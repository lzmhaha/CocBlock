MAP_RES_PATH = 'map/'

local BattleMap = class('BattleMap', function(resName)
    return cc.TMXTiledMap:create(MAP_RES_PATH..resName)
end)

function BattleMap:ctor()
    self:align(display.LEFT_BOTTOM)
    self.size = self:getContentSize()
    self.mapSize = self:getMapSize()
    self.tileSize = self:getTileSize()
    local w = self.size.width * (self.mapSize.height / (self.mapSize.width + self.mapSize.height))
    self.originPos = cc.p(w, self.size.height)
    self:setCameraMask(CAMERA_FRAG_BATTLE)

    self:addTouchListener()
end

function BattleMap:addTouchListener()
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self, BattleMap.onTouch))
    self:setTouchMode(cc.TOUCHES_ALL_AT_ONCE)
    self:setTouchEnabled(true)
end

function BattleMap:onTouch(event)
    points = event.points
    name = event.name
    local camera = self:getScene().battleCamera
    local cameraPos = cc.p(camera:getPosition())
    local dx = 0
    local dy = 0
    local i = 0
    local firstPoint
    local curScale = camera:getScale()
    local scale
    for id, point in pairs(points) do
        i = i + 1
        dx = dx + (point.x - point.prevX)
        dy = dy + (point.y - point.prevY)
        if i == 2 then
            -- local dis1 = cc.pGetDistance(firstPoint, point)
            -- local dis2 = cc.pGetDistance(cc.p(firstPoint.prevX, firstPoint.prevY), cc.p(point.prevX, point.prevY))
            -- scale = dis2 / dis1
            -- if scale * curScale > BATTLE_CAMERA_MAX_SCALE then scale = BATTLE_CAMERA_MAX_SCALE / curScale end
            -- if scale * curScale < BATTLE_CAMERA_MIN_SCALE then scale = BATTLE_CAMERA_MIN_SCALE / curScale end

            -- local center = cc.pMidpoint(cc.p(firstPoint.prevX, firstPoint.prevY), cc.p(point.prevX, point.prevY))
            -- dx = dx + (cameraPos.x - center.x) * (scale - 1)
            -- dy = dy + (cameraPos.y - center.y) * (scale - 1)

            break
        end
        firstPoint = point
    end

    camera:pos(cameraPos.x - dx / i, cameraPos.y - dy / i)
    if scale then camera:scale(scale * curScale) end
end

function BattleMap:getCenterPos()
    local l = self.mapSize.width + self.mapSize.height
    local x = l * self.tileSize.width * 0.25
    local y = l * self.tileSize.height * 0.25
    return cc.p(x, y)
end

function BattleMap:pos2Tile(posOrX, y)
    local x
    if type(posOrx) == 'table' then
        x = posOrX.x
        y = posOrX.y
    else
        x = posOrx
    end

    local dx = x - self.originPos.x
    local dy = self.originPos.y - y

    local tileX = math.floor(dx / self.tileSize.width + dy / self.tileSize.height)
    local tileY = math.floor(dy / self.tileSize.height - dx / self.tileSize.width)
    
    if tileX < 0 or tileX >= self.mapSize.width or tileY < 0 or tileY >= self.mapSize.height then
        return nil
    end
    
    return cc.p(tileX. tileY)
end

return BattleMap