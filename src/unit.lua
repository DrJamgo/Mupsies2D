require 'love'
require 'love.physics'
require 'love.math'
require 'lfs'

GenericUnit = {}
GenericUnit.__index = GenericUnit

GenericUnit.image = love.graphics.newImage("res/Minion.png")
GenericUnit.image_center = {32,32}

function GenericUnit.new(world)
  local self = setmetatable({}, GenericUnit)

  self.size = 50
  self.strength = 1000

  self.body = love.physics.newBody(world, 650/2, 650/2, "dynamic")
  self.shape = love.physics.newCircleShape(self.size / 2)
  self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1.
  self.fixture:setRestitution(0.1)

  return self
end

function GenericUnit.setTarget(self, target)
  self.target = target
end

function GenericUnit.update(self, dt)

  if self.target ~= nil then
    diffx, diffy = unpack(self.target)
    diffx = diffx - self.body:getX()
    diffy = diffy - self.body:getY()
    dist = math.sqrt(diffx*diffx + diffy*diffy)
    self.dir = math.atan2(diffy, diffx)
    force = math.min(1, dist / self.size) * self.strength
    self.body:applyForce(force * math.cos(self.dir), force * math.sin(self.dir))
  end

  velox, veloy = self.body:getLinearVelocity()
  self.body:applyForce(- (velox * math.abs(velox) * 0.1), - (veloy * math.abs(veloy) * 0.1))
end

function GenericUnit.draw(self, displayTransform)
	love.graphics.setColor(1, 1, 1)
    s = self.shape:getRadius() / 32
    transform = love.math.newTransform(self.body:getX(), self.body:getY(), self.dir, s, s, unpack(self.image_center))
    love.graphics.draw(self.image, transform)
end