require "unit"

Player = {}
Player.__index = Player

setmetatable(Player, {
  __index = GenericUnit, -- this is what makes the inheritance work
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Player._init(self, world, spawn)
  local player = {
    appearance = {
      sprite = "sprites/mupsine.png"
    }
  }
  
  GenericUnit._init(self, world, spawn, "player", player)
  
  self.behaviour.fraction = "player"
  self.behaviour.update = 
    function(self, dt, layer)
      local intention = {}
      
      if self.dir then
        intention.move = {
          dir = self.dir,
          dist = 64,
          dx = math.cos(self.dir) * 64,
          dx = math.sin(self.dir) * 64
        }
      end
      
      return intention
    end
  self.behaviour.setMovement = 
    function(self, dir)
      self.dir = dir
    end
end
