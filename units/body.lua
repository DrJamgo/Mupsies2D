--
-- Body class
--
-- Defines physical mainifistation and capabilities of an unit
--

require "units/ability"

Body = {}
Body.__index = Body
setmetatable(Body, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Body.new(world, spawn, bodyparams)
  local self = setmetatable({}, Body)
  
  self.size = bodyparams.size
  self.strength = bodyparams.strength

  -- init box2d objects
  self.body = love.physics.newBody(world, spawn.x + math.random(5), spawn.y + math.random(5), "dynamic")
  self.body:setFixedRotation(true)
  self.shape = love.physics.newCircleShape(self.size / 2)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  self.body:setMass(bodyparams.mass)
  
  -- init abilities
  if bodyparams.melee then
    local params = bodyparams.melee
    self.melee = AbilityAttack(
      self.body, params.cooldown, params.duration, params.trigger, params.damage, params.reach)
  end
  
  if bodyparams.move then
    self.move = AbilityMove(self.body, bodyparams.move.cooldown, bodyparams.move.force)
  end

  self.targets = {
    move = nil,
    attack = nil
  }
  
  return self
end

function Body:update(dt, intention)
  self.move:setIntention(intention.move)
  self.move:update(dt)
  self.melee:setIntention(intention.melee)
  self.melee:update(dt)
end

function Body:draw()
  
  love.graphics.setColor(1, 1, 1)
  -- draw debug stuff
  -- body dimensions
  love.graphics.setLineWidth(0.5)
  love.graphics.circle("line", self.body:getX(), self.body:getY(), self.size / 2)
  -- draw face direction
  love.graphics.line(self.body:getX(), self.body:getY(),
    self.body:getX() + math.cos(self.body:getAngle()) * self.size/2,
    self.body:getY() + math.sin(self.body:getAngle()) * self.size/2)
  -- draw attack reach
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("line", self.body:getX(), self.body:getY(), self.size / 2 + self.melee.reach)
  
end
