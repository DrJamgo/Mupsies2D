require 'saveload'

Gamestate = {}
Gamestate.__index = Gamestate
setmetatable(Gamestate, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Gamestate:_init(filename)
  self.progress = 0
  self.units = {}
  self.items = {}
  
  self:load(filename)
end

function Gamestate:load(filename)
  
  local state, err = table.load(filename or "auto.save.lua")
  
  if state ~= nil then
    for k,v in pairs(state) do
      self[k] = v
    end
  else
    self.progress = 0
    self:setLocation("00_tutorial", "start")
    self:addUnit("herder")
    self:addUnit("herder")
    self:addUnit("herder")
    self:addRemoveItem('meat', 3)
  end
end

function Gamestate:save(filename)
  table.save(self, filename or "auto.save.lua")
end

function Gamestate:addRemoveItem(itemtype, delta)
  self.items[itemtype] = (self.items[itemtype] or 0) + (delta or 1)
end

function Gamestate:setLocation(mapname, exitname)
  self.mapname = mapname
  self.exitname = exitname
end

function Gamestate:addUnit(unitname)
  self.units[#self.units+1] = unitname
end
