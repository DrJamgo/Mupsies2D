require 'gamestate'
require 'hud'
require 'unitslayer'
require 'spawnlayer'
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
  
  self.world = world
  self.map = map
  
  if map.properties.safe then
    self.state:save()
  end
  
  local spawnlayer = table.find(function(v) return v.name == "spawn" end, map.layers)
  SpawnLayer.initLayer(spawnlayer, self.state.exitname)
  
  -- find/create units layer
  local unitslayer = table.find(function(v) print(v.name) return v.name == "units" end, map.layers)
  if not unitslayer then
    unitslayer = map:addCustomLayer("units")
  end
  UnitsLayer.initLayer(unitslayer, self, spawnlayer)

  hudlayer = map:addCustomLayer("hud")
  Hud.initLayer(hudlayer, self)
  
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
end

function Game:draw()

  self.scale = 1.5

  local wx = self.unitslayer.player.body.body:getX()
  local wy = self.unitslayer.player.body.body:getY()

  local dx = (love.graphics.getWidth() / self.scale) / 2 - (self.unitslayer.player.body.body:getX() * 0.80 + wx * 0.2) 
  local dy = (love.graphics.getHeight() / self.scale) / 2 - (self.unitslayer.player.body.body:getY() * 0.80 + wy * 0.2) 
  
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