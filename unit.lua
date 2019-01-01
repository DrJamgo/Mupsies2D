require 'love'
require 'love.physics'
local lpcsprite = require('sprites/lpcsprite')

require('units/behaviour')
require('units/body')
require('units/appearance')

GenericUnit = {}
GenericUnit.__index = GenericUnit
setmetatable(GenericUnit, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

GenericUnit.image = love.graphics.newImage("sprites/mupsie.png")
GenericUnit.image_center = {32,48}

function GenericUnit._init(self, world, spawn, fraction, sprite)

  local spritesheet = sprite or "sprites/mupsie.png"
  self.body = Body(world, spawn)
  self.behaviour = Behaviour(self.body, fraction)
  self.appearance = Appearance(self, self.body, spritesheet)
  
  self.hp = 100
  self.hpmax = 100

  return self
end

function GenericUnit.getFraction(self)
  return self.behaviour.fraction
end

function GenericUnit.setTarget(self, target)
  self.body.targets.move = target
end

function GenericUnit.update(self, dt, layer)

  if self.hp > 0 then
    local intention = self.behaviour:update(dt, layer)
    self.body:update(dt, intention)
  elseif self.body.fixture then
    self.body.fixture:destroy()
    self.body.fixture = nil
    self.body.body:setType("static")
    self.body.body:setAngle(-math.pi / 2)
  end
  
  self.appearance:update(dt)
end

function GenericUnit.draw(self)
  --self.body:draw()
  self.appearance:draw()
end

function GenericUnit:hit(damage)
  self.hp = self.hp - damage
  self.appearance:hit(damage)
end

function GenericUnit:isAlive()
  return self.hp > 0
end