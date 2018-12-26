require 'love'
require 'love.physics'
local lpcsprite = require('sprites/lpcsprite')

GenericUnit = {}
GenericUnit.__index = GenericUnit

GenericUnit.image = love.graphics.newImage("sprites/mupsie.png")
GenericUnit.image_center = {32,48}

function GenericUnit.new(world, spawn)
  local self = setmetatable({}, GenericUnit)

  self.size = 24
  self.strength = 20

  self.body = love.physics.newBody(world, spawn.x + math.random(5), spawn.y + math.random(5), "dynamic")
  self.shape = love.physics.newCircleShape(self.size / 2)
  self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
  self.fixture:setRestitution(0.2)
  self.speed = 2.0
  self.boost = 0.0
  self.walk = 0.0
  self.anim = 'stand'

  return self
end

function GenericUnit.setTarget(self, target)
  self.target = target
end

function GenericUnit.update(self, dt)

  if self.boost > 0 then
    self.boost = self.boost - dt * self.speed
  end

  if self.target ~= nil then
    diffx, diffy = unpack(self.target)
    diffx = diffx - self.body:getX()
    diffy = diffy - self.body:getY()
    dist = math.sqrt(diffx*diffx + diffy*diffy)
    self.dir = math.atan2(diffy, diffx)
    force = math.min(1, dist / self.size) * self.strength
    --self.body:applyForce(force * math.cos(self.dir), force * math.sin(self.dir))
    if self.boost <= 0 then
      self.body:applyLinearImpulse(force * math.cos(self.dir), force * math.sin(self.dir))
      self.boost = self.boost + (1 / self.speed)
    end
    
    self.anim = 'walk'
  end

  

  velox, veloy = self.body:getLinearVelocity()
  veloabs = math.max(math.abs(velox),math.abs(veloy))
  if veloabs < 10 then
    self.body:setLinearVelocity(0,0)
    self.anim = 'stand'
  else
    self.walk = self.walk + dt * (veloabs / 16) * 2
    forcex = math.min(self.strength * 20, math.max(-self.strength * 20, velox * math.abs(velox) * 0.1))
    forcey = math.min(self.strength * 20, math.max(-self.strength * 20, veloy * math.abs(veloy) * 0.1))
    self.body:applyForce(- (velox), - (veloy))
  end
end

function GenericUnit.draw(self, displayTransform)
	love.graphics.setColor(1, 1, 1)
    s = self.shape:getRadius() / 16
    --transform = love.math.newTransform(self.body:getX(), self.body:getY(), self.dir, s, s, unpack(self.image_center))
    transform = love.math.newTransform(self.body:getX(), self.body:getY(), 0, s, s, unpack(self.image_center))
    love.graphics.draw(self.image, lpcsprite.getQuad(self.anim, self.dir, self.walk), transform)
    --love.graphics.circle( 'line', self.body:getX(), self.body:getY(), self.size/2)
end