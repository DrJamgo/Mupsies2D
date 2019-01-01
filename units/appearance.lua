--
-- Appearance class
--
-- Defines visual appearance and animations of an unit
--

local lpcsprite = require('sprites/lpcsprite')

local DAMAGETIME = 0.5

Appearance = {}
Appearance.__index = Appearance
setmetatable(Appearance, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Appearance.new(unit, body, spritesheet)
  local self = setmetatable({}, Appearance)
  
  spritesheet = spritesheet or "sprites/mupsie.png"
  
  self.body = body
  self.unit = unit
  self.sprite = love.graphics.newImage(spritesheet)
  self.sprite_center = {32,48}
  self.anim = "stand"
  self.slash = 0
  
  self.damage = {}
  
  return self
end

function Appearance:update(dt)

  local slash = self.body.melee:getProgress()
  local speed = 0
  local prone = self.unit.hp <= 0
  if self.body.move then
    speed = self.body.move:getSpeed()
  end
  
  if prone then
    self.anim = "prone"
    self.prone = (self.prone or 0) + dt
    self.time = self.prone
  elseif slash > 0 then
    self.anim = "slash"
    self.time = slash
  elseif math.abs(speed) > 5 then
    self.anim = "walk"
    self.walk = self.walk + dt * (speed / 16) * 2
    self.time = self.walk
  else
    self.anim = "stand"
    self.walk = 0.0
    self.time = 0.0
  end
  
  for k,v in pairs(self.damage) do
    if self.damage[k].time < DAMAGETIME then
      self.damage[k].time = self.damage[k].time + dt
    else
      table.remove(self.damage, k)
    end
  end
  
end

function Appearance:draw()
  if self.ishit then
    love.graphics.setColor(1, 0.5, 0.5)
    self.ishit = false
  else
    love.graphics.setColor(1, 1, 1)
  end
  local s = self.body.shape:getRadius() / 16
  local transform = love.math.newTransform(self.body.body:getX(), self.body.body:getY(), 0, s, s, unpack(self.sprite_center))
  local quad
  quad = lpcsprite.getQuad(self.anim, self.body.body:getAngle(), self.time)
  love.graphics.draw(self.sprite, quad, transform)
  --love.graphics.print(math.ceil(self.unit.hp),self.body.body:getX(), self.body.body:getY()-32, 0, 0.5, 0.5)
  
  love.graphics.setColor(1, 1, 1)
  for k,v in pairs(self.damage) do
    love.graphics.print(
      v.damage, self.body.body:getX(),
      self.body.body:getY() -32 - (v.time / DAMAGETIME) * 16, 0,
      (DAMAGETIME - v.time) / DAMAGETIME)
  end
end

function Appearance:hit(damage)
  self.ishit = true
  table.insert(self.damage, {damage=damage, time=0})
end