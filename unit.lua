require 'love'
require 'love.physics'
local utils = require('utils')
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

unitindex = {
  mupsie = {
    hpmax = 100,
    
    body = {
      size = 24,
      strength = 1000,
      mass = 50,
      melee = {
        cooldown = 1.0,
        duration = 0.5,
        trigger  = 0.3,
        damage   = 10,
        reach    = 32
      },
      move = {
        cooldown = 0.2,
        force = 1000
      }
    },
    appearance = {
      sprite = "mupsie"
    }
  },
  spider = {
    hpmax = 100,
    
    body = {
      size = 16,
      strength = 1000,
      mass = 20,
      melee = {
        cooldown = 1.0,
        duration = 0.5,
        trigger  = 0.3,
        damage   = 10,
        reach    = 16
      },
      move = {
        cooldown = 0.1,
        force = 1000
      }
    },
    appearance = {
      sprite = "spider"
    }
  }
}

local default = unitindex.mupsie

function GenericUnit._init(self, world, spawn, fraction, unit)

  local default = utils.deepcopy(default)
  local params = utils.merge(default, unit or {})

  self.body = Body(world, spawn, params.body)
  self.behaviour = Behaviour(self.body, fraction)
  self.appearance = Appearance(self, self.body, params.appearance)
  
  self.hp = params.hpmax
  self.hpmax = params.hpmax

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