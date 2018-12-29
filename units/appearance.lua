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
  -- todo walk animation
 
  local slash = self.body.slash:getProgress()
 
  if slash > 0 then
    self.slash = slash
    self.anim = "slash"
  elseif math.abs(self.body.state.speed) > 5 then
    self.anim = "walk"
    self.walk = self.walk + dt * (self.body.state.speed / 16) * 2
  else
    self.walk = 0.0
    self.anim = "stand"
  end
end

function Appearance:draw()
  love.graphics.setColor(1, 1, 1)
  local s = self.body.shape:getRadius() / 16
  local transform = love.math.newTransform(self.body.body:getX(), self.body.body:getY(), 0, s, s, unpack(self.sprite_center))
  local quad
  if self.anim == 'walk' then
    quad = lpcsprite.getQuad(self.anim, self.body.state.face, self.walk)
  else
    quad = lpcsprite.getQuad(self.anim, self.body.state.face, self.slash)
  end
  love.graphics.draw(self.sprite, quad, transform)
end