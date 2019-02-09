local utils = require 'utils'
local unitindex = require 'units/unitindex'

UnitsLayer = {}

function UnitsLayer:initLayer(game, spawnlayer)
  self.game = game
  self.spawnlayer = spawnlayer
  self.objects = self.objects or {}
  self.draw = UnitsLayer.draw
  self.update = UnitsLayer.update
  self.mousemoved = UnitsLayer.mousemoved

  
  for k, o in pairs(spawnlayer.objects) do
    if o.type == "spawn" then
      local count = o.properties.count or 1
      for i = 1, count do
        self.objects[#self.objects+1] = GenericUnit(game.world, {x=o.x, y=o.y}, o.name, o.properties.unit, o.properties.behaviour)
      end
      
    end
  end
  
  local player = Player(world, spawnlayer.spawn)
  self.objects[#self.objects+1] = player
  self.area = spawnlayer.spawn
  self.player = player
  
  if not map.properties.safe then
    for k,v in pairs(self.game.state.units) do
      self.objects[#self.objects+1] = GenericUnit(self.game.world, spawnlayer.spawn, 'player', v)
    end
  end  
end

-- Draw units layer
function UnitsLayer:draw()
  for k,v in pairs(self.objects) do
    if v:isAlive() == false then
      v:draw()
    end
  end
  
  for k,v in utils.spairs(self.objects,
    function(o,a,b)
      return o[b].body.body:getY() > o[a].body.body:getY()
    end) do
    if v:isAlive() == true then
      v:draw()
    end
  end
end

-- Update units layer
function UnitsLayer:update(dt)
  
  local w = love.keyboard.isDown( 'w' )
  local a = love.keyboard.isDown( 'a' )
  local s = love.keyboard.isDown( 's' )
  local d = love.keyboard.isDown( 'd' )
  
  local moveX = 0
  local moveY = 0
  
  if d then moveX = 1 end
  if a then moveX = moveX - 1 end
  if s then moveY = 1 end
  if w then moveY = moveY - 1 end
  
  if a or s or d or w then
    self.player.behaviour:setMovement(math.atan2(moveY, moveX))
  else
    self.player.behaviour:setMovement(nil)
  end
  
  for k,v in pairs(self.objects) do
    if v:getFraction() == 'player' then
      if self.cursor then
        if self.cursor.button == 1 then
          v:setTarget({self.cursor.wx, self.cursor.wy})
        else
          local distx = self.player.body.body:getX() - v.body.body:getX()
          local disty = self.player.body.body:getY() - v.body.body:getY()
          local dist = math.sqrt(distx*distx + disty*disty)
          if dist > 128 then
            v:setTarget({self.player.body.body:getX(), self.player.body.body:getY()})
          else
            v:setTarget(nil)
          end
        end
      end
    end
    
    v:update(dt, self)
  end
  
  local lastarea = self.area
  local currentarea
  for k,area in pairs(self.spawnlayer.objects) do
    if utils.inarea({x=self.player.body.body:getX(), y=self.player.body.body:getY()}, area) then
      currentarea = area
    end
  end
  self.area = currentarea
  
  if currentarea and currentarea ~= lastarea 
      and currentarea.type == "exit" and currentarea.properties.map then
    self.game:leave()
    self.game:enter(currentarea.properties.map, currentarea.properties.exit)
  end
end

function UnitsLayer:mousemoved(x, y, dx, dy, istouch , button)
  local wx, wy = love.graphics.inverseTransformPoint( x, y )
  self.cursor = {x=x, y=y, wx=wx, wy=wy, button=button}
end
