--
-- Appearance class
--
-- Defines visual appearance and animations of an unit
--

local lpcsprite = require('sprites/lpcsprite')

local DAMAGETIME = 0.8

Appearance = {}
Appearance.__index = Appearance
setmetatable(Appearance, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Appearance.new(unit, body, params)
  local self = setmetatable({}, Appearance)
  
  self.body = body
  self.unit = unit
  self.sprite = lpcsprite.getSprite(params.sprite)
  self.anim = "stand"
  self.slash = 0
  self.thrust = params.thrust or false
  
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
    if self.thrust then
      self.anim = "thrust"
    else
      self.anim = "slash"
    end
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
  local width = self.body.shape:getRadius() * 2
  local x,y = self.body.body:getX(), self.body.body:getY()
  local headoffset = -self.body.shape:getRadius() * 3.0
  
  self.sprite.draw(self.sprite, self.anim, self.body.body:getAngle(), self.time, x, y, s)
  
  --love.graphics.print(math.ceil(self.unit.hp),self.body.body:getX(), self.body.body:getY()-32, 0, 0.5, 0.5)
  
  love.graphics.setColor(1, 1, 1)
  for k,v in pairs(self.damage) do
    love.graphics.print(v.damage,
      x,
      y + headoffset - (v.time / DAMAGETIME) * 16, 0,
      (DAMAGETIME - v.time) / DAMAGETIME)
  end
    --[[
    
  CAUSES MASSIVE PERFORMANCE ISSUES
  local life = self.unit.hp / self.unit.hpmax
  if life < 0.25 then
    love.graphics.setColor(1, 0, 0, 0.8)
  elseif life < 0.5 then
    love.graphics.setColor(1, 1, 0, 0.7)
  else
    love.graphics.setColor(0, 1, 0, 0.5)
  end
  
  love.graphics.rectangle("fill", x - (width / 4) * life, y + headoffset, (width / 2) * life, 4)

  ]]--
end

function Appearance:hit(damage)
  self.ishit = true
  table.insert(self.damage, {damage=damage, time=0})
end