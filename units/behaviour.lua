--
-- Behaviour class
--
-- Defines behaviour and personality of an unit
--

local function distanceBetweenUnits(unit1, unit2)
  local dx = unit2.body.body:getX() - unit1.body.body:getX()
  local dy = unit2.body.body:getY() - unit1.body.body:getY()
  return math.sqrt(dx*dx + dy*dy) - unit1.body.size / 2 - unit2.body.size / 2, dx, dy
end

Behaviour = {}
Behaviour.__index = Behaviour
setmetatable(Behaviour, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Behaviour.new(body, fraction)
  local self = setmetatable({}, Behaviour)
  
  self.body = body
  self.fraction = fraction
  
  -- TODO: define somehow
  self.sight = 128

  return self
end

function Behaviour:_isUnitEnemy(unit)
  return unit:getFraction() ~= self.fraction
end

function Behaviour:_findClosestEnemy(unitlayer)
  local enemy = nil
  local distance = nil
  local dx, dy
  for k,v in pairs(unitlayer.units) do
    if self:_isUnitEnemy(v) and v:isAlive() then
      dist, dx, dy = distanceBetweenUnits(self, v)
      if dist < self.sight and (not distance or dist < distance) then
        distance = dist
        enemy = v
      end
    end
  end
  return enemy, distance, dx, dy
end

function Behaviour:update(dt, unitlayer)
  local intention = {
  }
  
  if self.body.targets.move ~= nil then
    diffx, diffy = unpack(self.body.targets.move)
    diffx = diffx - self.body.body:getX()
    diffy = diffy - self.body.body:getY()
    local dist = math.sqrt(diffx*diffx + diffy*diffy)
    if dist > self.body.size / 2 then
      intention.move = {
        dx = diffx,
        dy = diffy,
        dir = math.atan2(diffy, diffx),
        dist = dist
      }
    end
  end
  
  local enemy, dist, dx, dy = self:_findClosestEnemy(unitlayer)
  
  if enemy then
    -- check if in melee reach
    if self.body.melee and self.body.melee.reach >= dist then
      intention.melee = {
        unit = enemy,
        dx = dx,
        dy = dy,
        dir = math.atan2(dy, dx),
        dist = dist
      }
    -- check if in range reach
    elseif self.body.range and self.body.range.reach >= dist then
      intention.range = {
        unit = enemy,
        dx = dx,
        dy = dy,
        dir = math.atan2(dy, dx),
        dist = dist
      }
    -- check if any attack possible, then move closer
    elseif self.body.melee or self.body.range then
      intention.move = {
        dx = dx,
        dy = dy,
        dir = math.atan2(dy, dx),
        dist = dist
      }
    end

  end
  
  return intention
end

BehaviourAggressive = {}
BehaviourAggressive.__index = BehaviourAggressive

setmetatable(BehaviourAggressive, {
  __index = Behaviour, -- this is what makes the inheritance work
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})