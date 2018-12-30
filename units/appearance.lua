--
-- Appearance class
--
-- Defines visual appearance and animations of an unit
--

local lpcsprite = require('sprites/lpcsprite')

Appearance = {}
Appearance.__index = Appearance
setmetatable(Appearance, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Appearance.new(body, spritesheet)
  local self = setmetatable({}, Appearance)
  
  spritesheet = spritesheet or "sprites/mupsie.png"
  
  self.body = body
  self.sprite = love.graphics.newImage(spritesheet)
  self.sprite_center = {32,48}
  self.anim = "stand"
  self.slash = 0
  
  return self
end

function Appearance:update(dt)

  local slash = self.body.melee:getProgress()
  local speed = 0
  if self.body.move then
    speed = self.body.move:getSpeed()
  end
 
  if slash > 0 then
    self.anim = "slash"
    self.slash = slash
  elseif math.abs(speed) > 5 then
    self.anim = "walk"
    self.walk = self.walk + dt * (speed / 16) * 2
  else
    self.anim = "stand"
    self.walk = 0.0
  end
end

function Appearance:draw()
  love.graphics.setColor(1, 1, 1)
  local s = self.body.shape:getRadius() / 16
  local transform = love.math.newTransform(self.body.body:getX(), self.body.body:getY(), 0, s, s, unpack(self.sprite_center))
  local quad
  if self.anim == 'walk' then
    quad = lpcsprite.getQuad(self.anim, self.body.body:getAngle(), self.walk)
  else
    quad = lpcsprite.getQuad(self.anim, self.body.body:getAngle(), self.slash)
  end
  love.graphics.draw(self.sprite, quad, transform)
end