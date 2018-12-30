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

function Body.new(world, spawn)
  local self = setmetatable({}, Body)
  
  self.size = 24
  self.strength = 400
  self.reach = 16

  self.body = love.physics.newBody(world, spawn.x + math.random(5), spawn.y + math.random(5), "dynamic")
  self.body:setFixedRotation(true)

  self.shape = love.physics.newCircleShape(self.size / 2)
  self.fixture = love.physics.newFixture(self.body, self.shape)
  
  self.body:setMass(50)
  
  self.melee = AbilityAttack(self.body, 2.0, 0.5, 0.25, 100, self.size / 2 + 8)
  self.move = AbilityMove(self.body, 0.2, self.strength)

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
