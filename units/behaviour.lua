--
-- Behaviour class
--
-- Defines behaviour and personality of an unit
--

Behaviour = {}
Behaviour.__index = Behaviour
setmetatable(Behaviour, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Behaviour.new(body, fraction)
  local self = setmetatable({}, Behaviour)
  
  self.body = body
  self.fraction = fraction

  return self
end

function Behaviour.update(self, dt, layer)
  local intention = {
  }
  
  if self.body.targets.move ~= nil then
    diffx, diffy = unpack(self.body.targets.move)
    diffx = diffx - self.body.body:getX()
    diffy = diffy - self.body.body:getY()
    local dist = math.sqrt(diffx*diffx + diffy*diffy)
    if dist > self.body.size / 2 then
      intention.move = {
        dx = diffx,
        dy = diffy,
        dir = math.atan2(diffy, diffx),
        dist = dist
      }
    end
  end
  
    --update attack stuff
  for k,v in pairs(layer.units) do
    if v:getFraction() ~= self.fraction and v:isAlive() then
      distance, x1, y1, x2, y2 = love.physics.getDistance(self.body.fixture, v.body.fixture)
      --print("distance=" .. distance .. ", reach=" .. self.body.slash.reach)
      if distance < self.body.melee.reach then
        intention.melee = {
          unit = v,
          dx = x2-x1,
          dy = y2-y1,
          dir = math.atan2(y2 - self.body.body:getY(), x2 - self.body.body:getX()),
          dist = distance
        }
      end
    end
  end
  
  return intention
end

