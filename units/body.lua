--
-- Body class
--
-- Defines physical mainifistation and capabilities of an unit
--

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
  self.strength = 5
  self.reach = 16

  self.body = love.physics.newBody(world, spawn.x + math.random(5), spawn.y + math.random(5), "dynamic")
  self.shape = love.physics.newCircleShape(self.size / 2)
  self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
  
  -- body state variables
  self.state = {
    face = 0.0,  -- facing direction in radians
    speed = 0.0, -- current speed in facing direction
  }
  
  self.cooldowns = {
    move = 0.0,
    slash = 0.0
  }
  
  self.movefequency = 10.0
  self.slashfrequency = 0.5
  
  self.targets = {
    move = nil,
    attack = nil
  }
  
  return self
end

function Body:update(dt, intention)
  
  if intention then
    if intention.slash then
      if self.cooldowns.slash <= 0 then
        intention.slash.unit.body.body:applyLinearImpulse(math.cos(intention.slash.dir) * 10, math.sin(intention.slash.dir) * 10)
        self.cooldowns.slash = self.cooldowns.slash + (1 / self.slashfrequency)
      end
    end
    if intention.move then
      if self.cooldowns.move <= 0 then
        self.state.face = intention.move.dir
        
        force = math.min(1, intention.move.dist / self.size) * self.strength
        self.body:applyLinearImpulse(force * math.cos(intention.move.dir), force * math.sin(intention.move.dir))
        self.cooldowns.move = self.cooldowns.move + (1 / self.movefequency)
      end
    end
    

  end
  
  velox, veloy = self.body:getLinearVelocity()
  facex, facey = math.cos(self.state.face), math.sin(self.state.face)
  self.state.speed = velox * facex + veloy * facey
  
  veloabs = math.max(math.abs(velox),math.abs(veloy))
  if veloabs < 5 then
    self.body:setLinearVelocity(0,0)
  else
    forcex = math.min(self.strength * 20, math.max(-self.strength * 20, velox * math.abs(velox) * 0.1))
    forcey = math.min(self.strength * 20, math.max(-self.strength * 20, veloy * math.abs(veloy) * 0.1))
    self.body:applyForce(- (velox), - (veloy))
  end
  
  for k,v in pairs(self.cooldowns) do
    if self.cooldowns[k] > 0 then
      self.cooldowns[k] = self.cooldowns[k] - dt
    end
  end
  
end

function Body:draw()
  
  love.graphics.setColor(1, 1, 1)
  -- draw debug stuff
  -- body dimensions
  love.graphics.setLineWidth(0.5)
  love.graphics.circle("line", self.body:getX(), self.body:getY(), self.size / 2)
  -- draw face direction
  love.graphics.line(self.body:getX(), self.body:getY(),
    self.body:getX() + math.cos(self.state.face) * self.size/2,
    self.body:getY() + math.sin(self.state.face) * self.size/2)
  -- draw attack reach
  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("line", self.body:getX(), self.body:getY(), self.size / 2 + self.reach)
  

  
end
