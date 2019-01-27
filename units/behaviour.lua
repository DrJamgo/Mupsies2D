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
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Behaviour:_init(body, fraction)

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
  for k,v in pairs(unitlayer.objects) do
    if self:_isUnitEnemy(v) and v:isAlive() then
      dist, _dx, _dy = distanceBetweenUnits(self, v)
      if dist < self.sight and (not distance or dist < distance) then
        distance = dist
        enemy = v
        dx, dy = _dx, _dy
      end
    end
  end
  return enemy, distance, dx, dy
end

function Behaviour:_attackEnemy(intention, enemy, dist, dx, dy)
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
    self:_attackEnemy(intention, enemy, dist, dx, dy)
  end
  
  return intention
end

--
-- Attacks every enemy (not own fraction) in sight
--
Aggressive = {}
Aggressive.__index = Aggressive

setmetatable(Aggressive, {
  __index = Behaviour, -- this is what makes the inheritance work
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Aggressive:update(dt, unitlayer)
  local intention = {}
  local enemy, dist, dx, dy
  if self.enemy then
    dist, dx, dy = distanceBetweenUnits(self, self.enemy)
    if not self.body.melee or (self.body.melee and dist > self.sight) or not self.enemy:isAlive() then
      self.enemy = nil
      enemy = nil
    else
      enemy = self.enemy
    end
  end
  
  if not enemy then
    enemy, dist, dx, dy = self:_findClosestEnemy(unitlayer)
  end
  
  if enemy then
    self:_attackEnemy(intention, enemy, dist, dx, dy)
    self.enemy = enemy
  end
  
  return intention
end

