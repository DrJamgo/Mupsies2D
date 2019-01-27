require 'gamestate'
require 'hud'
local utils = require 'utils'
local sti = require "STI/sti"

Game = {}
Game.__index = Game
setmetatable(Game, {
  __call = function (cls, ...)
    local self = setmetatable({}, cls)
    self:_init(...)
    return self
  end,
})

function Game:_init(filename)
  self.state = Gamestate(filename)
end

function Game:save(filename)
  self.state:save(filename)
end

function Game:enter(mapname, exitname)
  
  love.physics.setMeter(32) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 0, true)

  if mapname and exitname then
    self.state:setLocation(mapname, exitname)
  end

  -- load map and initialize box2d objects
  map = sti("maps/"..(self.state.mapname)..".lua", { "box2d" })
  map:box2d_init(world)
  
  if map.properties.sefe then
    self.state:save()
  end
  
  -- find/create units layer
  local unitslayer = table.find(function(v) return v.name == "units" end, map.layers)
  if not self.unitslayer then
    unitslayer = map:addCustomLayer("units")
  end
  unitslayer.objects = unitslayer.objects or {}
  
  local spawnlayer = table.find(function(v) return v.name == "spawn" end, map.layers)
  
    -- find Spawn object in map
  local spawn = table.find(
    function(o) return o.name == (self.state.exitname) and o.type == "exit" end, spawnlayer.objects)
  
  for k, o in pairs(spawnlayer.objects) do
    if o.type == "spawn" then
      local count = o.properties.count or 1
      local unit = unitindex[o.properties.unit] or unitindex.spider
      for i = 1, count do
        layer.units[#layer.units+1] = GenericUnit(world, {x=o.x, y=o.y}, o.name, unit, o.properties.behaviour)
      end
      
    end
  end
  
  local player = Player(world, spawn)
  unitslayer.objects[#unitslayer.objects+1] = player
  self.area = spawn
  
  if not map.properties.safe then
    for k,v in pairs(self.state.units) do
      unitslayer.objects[#unitslayer.objects+1] = GenericUnit(world, spawn, 'player', v)
    end
  end  
    -- Draw units layer
	unitslayer.draw = function(self)
    
    for k,v in pairs(unitslayer.objects) do
      if v:isAlive() == false then
        v:draw()
      end
    end
    
    
    for k,v in utils.spairs(unitslayer.objects,
      function(o,a,b)
        return o[b].body.body:getY() > o[a].body.body:getY()
      end) do
      if v:isAlive() == true then
        v:draw()
      end
    end
	end
  
  -- Update units layer
	unitslayer.update = function(self, dt)
    
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
      player.behaviour:setMovement(math.atan2(moveY, moveX))
    else
      player.behaviour:setMovement(nil)
    end
    
    for k,v in pairs(unitslayer.objects) do
      if v:getFraction() == 'player' then
        if mybutton == 1 then
          v:setTarget({wx,wy})
        elseif mybutton == 2 then
          v:setTarget({player.body.body:getX(), player.body.body:getY()})
        end
      end
      
      v:update(dt, unitslayer)
      
    end
	end
  
  hudlayer = map:addCustomLayer("hud")
  Hud._init(hudlayer, self)
  
  self.world = world
  self.map = map
  self.unitslayer = unitslayer
  self.spawnlayer = spawnlayer
  self.player = player
end

function Game:leave()
  if self.map.properties.safe then
    self.state:save()
  end
  
  self.world:destroy()
  self.world:release()
  self.world = nil
  self.map = nil
  self.unitslayer = nil
  self.player = nil
end

function Game:update(dt)
  self.map:update(dt)
  self.world:update(dt)
  
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
    self:leave()
    self:enter(currentarea.properties.map, currentarea.properties.exit)
  end
end

function Game:draw()

  self.scale = 1.5

  local wx = self.player.body.body:getX()
  local wy = self.player.body.body:getY()

  local dx = (love.graphics.getWidth() / self.scale) / 2 - (self.player.body.body:getX() * 0.80 + wx * 0.2) 
  local dy = (love.graphics.getHeight() / self.scale) / 2 - (self.player.body.body:getY() * 0.80 + wy * 0.2) 
  
  local w = map.width * map.tilewidth
  local h = map.height * map.tileheight
  
  dx = math.max(math.min(dx, 0), -(w - love.graphics.getWidth() / self.scale))
  dy = math.max(math.min(dy, 0), -(h - love.graphics.getHeight() / self.scale))
  
  love.graphics.setColor(255, 255, 255)
  displayTransform = love.math.newTransform()
  displayTransform:scale(self.scale)
  displayTransform:translate(dx , dy)

  love.graphics.replaceTransform(displayTransform)
  
	map:draw(dx,dy,self.scale,self.scale)
  if love.keyboard.isDown('b') then
    map:box2d_draw()
  end
end

function Game:mousereleased(x, y, button, istouch, presses)
  for i = #self.map.layers, 1, -1 do
    local layer = self.map.layers[i]
    if layer.mousereleased then
      local hit = layer:mousereleased(x, y, button, istouch, presses)
      if hit then return hit end
    end
  end
end

function Game:mousemoved(x, y, dx, dy, istouch , button)
  for i = #self.map.layers, 1, -1 do
    local layer = self.map.layers[i]
    if layer.mousemoved then
      local hit = layer:mousemoved(x, y, dx, dy, istouch , button)
      if hit then return hit end
    end
  end
end