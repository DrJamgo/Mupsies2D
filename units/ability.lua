Ability = {}
Ability.__index = Ability
setmetatable(Ability, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Ability:_init(cooldown, duration, trigger)
  
  self.cooldown = cooldown or 0
  self.duration = duration or 0
  self.trigger = trigger or 0
  
  self.time = 0
  self.active = false
  
  return self
end

function Ability:update(dt)
  local trigger = self.time > self.trigger
  
  if self.active then
    self.time = self.time + dt
  end
  
  trigger = (trigger == false) and (self.time > self.trigger)
  
  if self.time > self.cooldown then
    self.active = false
    self.time = self.time - self.cooldown
  end
  
  return trigger
end

function Ability:isReady()
  return self.active == false
end

--
-- Activates ability (starts cooldown)
-- @return true if ability was ready and is now acive, false otherwise
--
function Ability:activate()
  local isReady = self:isReady()
  if isReady then
    self.active = true
  end
  return isReady
end

function Ability:getProgress()
  if self.active == false or self.time > self.duration then
    return 0
  end
  return self.time / math.max(self.duration, 0.0001)
end


--
-------------------------------------------------------------------------------
--

AbilityMove = {}
AbilityMove.__index = AbilityMove

setmetatable(AbilityMove, {
  __index = Ability, -- this is what makes the inheritance work
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function AbilityMove:_init(body, cooldown, force)
  self.body = body
  self.force = force
  self.speed = 0
  
  Ability._init(self, cooldown)
end

function AbilityMove:update(dt)
  Ability.update(self, dt)
  
    -- calculate counter-forces
  local velox, veloy = self.body:getLinearVelocity()
  local forcex = -velox * self.body:getMass() * 2
  local forcey = -veloy * self.body:getMass() * 2
  self.body:applyForce((forcex), (forcey))
  
  -- update states and variables
  self.speed = velox * math.cos(self.body:getAngle()) + veloy * math.sin(self.body:getAngle())

  -- apply move force if 'ready' and intent to move exists
  local intention = self.intention or {dir = 0, dist = 0}
  if self.intention then
    self.body:setAngle(intention.dir)
  elseif math.abs(self.speed) > 1 then
    intention = {dir = math.atan2(-veloy, -velox), dist = math.abs(self.speed)}
  end
  
  if intention ~= nil then
    if Ability.activate(self) then
      local force = math.min(1, (intention.dist - self.speed) / 32) * self.force
      if force > self.body:getMass() then
        self.body:applyLinearImpulse(
          force * math.cos(intention.dir),
          force * math.sin(intention.dir))
      end
    end
  end
end

function AbilityMove:setIntention(intention)
  self.intention = intention
end

function AbilityMove:getSpeed()
  return self.speed
end

--
-------------------------------------------------------------------------------
--

AbilityAttack = {}
AbilityAttack.__index = AbilityAttack

setmetatable(AbilityAttack, {
  __index = Ability, -- this is what makes the inheritance work
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function AbilityAttack:_init(body, cooldown, duration, trigger, damage, reach)
  self.body = body
  self.damage = damage or 1
  self.reach = reach or 0
  
  Ability._init(self, cooldown, duration, trigger)
end

function AbilityAttack:update(dt)
  local attack = Ability.update(self, dt)

  if attack then
    self.target.body.body:applyLinearImpulse(math.cos(self.dir) * self.damage, math.sin(self.dir) * self.damage * 100)
    self.target:hit(self.damage)
  end
  
  if self.intention then
    if self:activate() then
      self.target = self.intention.unit
      self.dir = self.intention.dir
    end
  end
end

function AbilityAttack:setIntention(intention)
  self.intention = intention
end