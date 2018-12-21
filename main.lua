require 'unit'
require 'maps/maploader'

currentmap = require('maps/map0')

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  love.physics.setMeter(64) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 0, true)

  maploader.load(world, currentmap)

  numballs = 5
  objects = {} -- table to hold all our physical objects

  --let's create the ground
  objects.ground = {}
  objects.ground.body = love.physics.newBody(world, 650/2, 650-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (650/2, 650-50/2)
  objects.ground.shape = love.physics.newRectangleShape(650, 50) --make a rectangle with a width of 650 and a height of 50
  objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape) --attach shape to body
 
  --let's create a ball
  objects.ball = {}

  for i = 0, numballs do
    objects.ball[i] = GenericUnit.new(world)
  end
 
  --let's create a couple blocks to play around with
  objects.block1 = {}
  objects.block1.body = love.physics.newBody(world, 200, 550, "static")
  objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 150)
  objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.
 
  objects.block2 = {}
  objects.block2.body = love.physics.newBody(world, 200, 350, "static")
  objects.block2.shape = love.physics.newRectangleShape(0, 0, 150, 50)
  objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)

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

  for i = 1, numballs do
    if mybutton == 1 then
      objects.ball[i]:setTarget({x,y})
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
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

  
  love.graphics.setColor(0.28, 0.63, 0.05) -- set the drawing color to green for the ground
  love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

  for i = 1, numballs do
    objects.ball[i]:draw()
  end

  love.graphics.setColor(0.2, 0.2, 0.2) --set the drawing color to red for the ball

  for i = 1, numballs do
  	velox, veloy = objects.ball[i].body:getLinearVelocity()
    --love.graphics.line(objects.ball[i].body:getX(), objects.ball[i].body:getY(), objects.ball[i].body:getX() + velox, objects.ball[i].body:getY() + veloy)
  end


  love.graphics.setColor(0.20, 0.20, 0.20) -- set the drawing color to grey for the blocks
  love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
  love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))


end