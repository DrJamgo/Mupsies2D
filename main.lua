if arg[#arg] == "-debug" then require("mobdebug").start() end

require 'unit'
require 'maps/maploader'
-- love.filesystem.load("tiledloader.lua")()

local sti = require "sti"
local utils = require "utils"
--currentmap = require('maps/map0')
displayTransform = love.math.newTransform()

function love.load()
  
  love.physics.setMeter(32) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 0, true)

  -- load map and initialize box2d objects
  map = sti("maps/map0.lua", { "box2d" })
  map:box2d_init(world)

  -- find Spawn objetct in map
  local spawn = {x=0,y=0}
  local enemy = {x=200,y=200}
  for k, o in pairs(map.objects) do
    if o.name == "spawn" then
      spawn = {x=o.x,y=o.y}
    end
    if o.name == "enemy" then
      enemy = {x=o.x,y=o.y}
    end
  end
  
  -- Create new dynamic data layer called "Sprites" as the 8th layer
	local layer = map:addCustomLayer("units")
  
  layer.units = {}

  for i = 1, 1 do
    layer.units[#layer.units+1] = GenericUnit(world, spawn, 'player')
  end
  
  layer.units[#layer.units+1] = GenericUnit(world, enemy, 'enemy')
 
  -- Draw units layer
	layer.draw = function(self)
    for k,v in utils.spairs(self.units, function(o,a,b) return o[b].body.body:getY() > o[a].body.body:getY() end) do
      v:draw()
    end
	end
  
  -- Update units layer
	layer.update = function(self, dt)
    for k,v in pairs(self.units) do
      if v:getFraction() == 'player' then
        if mybutton == 1 then
          v:setTarget({wx,wy})
        elseif mybutton == 2 then
          v:setTarget(nil)
        end
      end
      v:update(dt, layer)
    end
	end
 
  --initial graphics setup
  love.graphics.setBackgroundColor(0.41, 0.53, 0.97) --set the background color to a nice blue
  love.window.setMode(640, 640) --set the window dimensions to 650 by 650 with no fullscreen, vsync on, and no antialiasing
end

function love.mousepressed( x, y, button, istouch, presses )
  mybutton = button
  love.mousemoved(x,y,0,0,istouch)
end

function love.mousereleased( x, y, button, istouch, presses )
  mybutton = 0
end

function love.mousemoved( x, y, dx, dy, istouch )

  wx, wy = displayTransform:inverseTransformPoint( x, y )

end

function love.update(dt)
  map:update(dt)
  world:update(dt) --this puts the world into motion
end

function love.draw()
  
  love.graphics.setColor(255, 255, 255)
  displayTransform = love.math.newTransform()
  displayTransform:scale(2.0)
  love.graphics.replaceTransform(displayTransform)
  
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

	map:draw(0,0,2.0,2.0)
  map:box2d_draw()

end