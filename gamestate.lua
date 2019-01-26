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
  if filename then
    -- TODO: load from file
  else
    -- load default game
    self.progress = 0
    self:setLocation("01_oasis", "w")
    self.units = {}
    self:addUnit("mupsie")
    self:addUnit("mupsie")
    self:addUnit("mupsie")
    self:addUnit("mupsie")
    self.items = {}
    self:addRemoveItem('meat', 3)
  end
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
