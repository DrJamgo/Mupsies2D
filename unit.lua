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
    return cls.new(...)
  end,
})

GenericUnit.image = love.graphics.newImage("sprites/mupsie.png")
GenericUnit.image_center = {32,48}

function GenericUnit.new(world, spawn, fraction)
  local self = setmetatable({}, GenericUnit)

  self.body = Body(world, spawn)
  self.behaviour = Behaviour(self.body, fraction)
  self.appearance = Appearance(self.body, "sprites/mupsie.png")
  
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

  local intention = self.behaviour:update(dt, layer)
  self.body:update(dt, intention)
  self.appearance:update(dt)
  
end

function GenericUnit.draw(self)
  --self.body:draw()
  self.appearance:draw()
end