if arg[#arg] == "-debug" then require("mobdebug").start() end

require 'unit'
require 'maps/maploader'
-- love.filesystem.load("tiledloader.lua")()

local sti = require "sti"

--currentmap = require('maps/map0')
displayTransform = love.math.newTransform()

function love.load()
  
  
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 0, true)

  --mapobjects = maploader.load(world, currentmap)
  
  map = sti("maps/map0.lua", { "box2d" })
  
  map:box2d_init(world)

  numballs = 5
  objects = {} -- table to hold all our physical objects

  --let's create a ball
  objects.ball = {}

  for i = 0, numballs do
    objects.ball[i] = GenericUnit.new(world)
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

  for i = 1, numballs do
    if mybutton == 1 then
      objects.ball[i]:setTarget({wx,wy})
    elseif mybutton == 2 then
      objects.ball[i]:setTarget(nil)
    end
  end
end

function love.update(dt)
  for i = 1, numballs do
  	objects.ball[i]:update(dt)
  end

  world:update(dt) --this puts the world into motion
end

function love.draw()
  
  love.graphics.setColor(255, 255, 255)
  displayTransform = love.math.newTransform()
  displayTransform:scale(2.0)
  love.graphics.replaceTransform(displayTransform)
  
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

	map:draw(0,0,2.0,2.0)
  --map:box2d_draw()

  for i = 1, numballs do
    objects.ball[i]:draw()
  end

--  for k, v in pairs(mapobjects) do
--    if v.draw ~= nil then
--      v:draw()
--    end
--  end


end