if arg[#arg] == "-debug" then require("mobdebug").start() end

require 'unit'
require 'units/player'

require 'gamestate'

local sti = require "STI/sti"
local utils = require "utils"

displayTransform = love.math.newTransform()

local wx,wy = 0,0
local player

mybutton = 2

gamestate = Gamestate()


function love.load()
  
  love.physics.setMeter(32) --the height of a meter our worlds will be 64px
  world = love.physics.newWorld(0, 0, true)

  -- load map and initialize box2d objects
  map = sti("maps/"..gamestate.mapname..".lua", { "box2d" })
  map:box2d_init(world)
  
  local layer
  for k, o in pairs(map.layers) do
    if map.layers[k].name == "units" then
      layer = map.layers[k]
      break
    end
  end
  
  -- Create new dynamic data layer called "Sprites" as the 8th layer
  if not layer then
    layer = map:addCustomLayer("units")
  end
  
  layer.units = {}
  
    -- find Spawn objetct in map
  local spawn = {x=0,y=0}
  for k, o in pairs(map.objects) do
    if o.name == gamestate.exitname and o.type == "exit" then
      spawn = {x=o.x + o.width/2,y=o.y + o.height/2}
    elseif o.type == "spawn" then
      local count = o.properties.count or 1
      local unit = unitindex[o.properties.unit] or unitindex.spider
      for i = 1, count do
        layer.units[#layer.units+1] = GenericUnit(world, {x=o.x, y=o.y}, o.name, unit, o.properties.behaviour)
      end
      
    end
  end

  player = Player(world, spawn)
  layer.units[#layer.units+1] = player

  if not map.properties.safe then
    for k,v in pairs(gamestate.units) do
      local unit = unitindex[v]
      layer.units[#layer.units+1] = GenericUnit(world, spawn, 'player', unit)
    end
  end
 
  -- Draw units layer
	layer.draw = function(self)
    
    for k,v in pairs(self.units) do
      if v:isAlive() == false then
        v:draw()
      end
    end
    
    
    for k,v in utils.spairs(self.units,
      function(o,a,b)
        return o[b].body.body:getY() > o[a].body.body:getY()
      end) do
      if v:isAlive() == true then
        v:draw()
      end
    end
	end
  
  -- Update units layer
	layer.update = function(self, dt)
    
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
    
    for k,v in pairs(self.units) do
      if v:getFraction() == 'player' then
        if mybutton == 1 then
          v:setTarget({wx,wy})
        elseif mybutton == 2 then
          v:setTarget({player.body.body:getX(), player.body.body:getY()})
        end
      end
      
      v:update(dt, layer)
      
    end
	end
 
  --initial graphics setup
  love.graphics.setBackgroundColor(0.0, 0.0, 0.0) --set the background color to a nice blue
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
  
  local s = 1.5
  local dx = (love.graphics.getWidth() /s) / 2 - (player.body.body:getX() * 0.80 + wx * 0.2) 
  local dy = (love.graphics.getHeight() / s) / 2 - (player.body.body:getY() * 0.80 + wy * 0.2) 
  
  local w = map.width * map.tilewidth
  local h = map.height * map.tileheight
  
  dx = math.max(math.min(dx, 0), -(w - love.graphics.getWidth() / s))
  dy = math.max(math.min(dy, 0), -(h - love.graphics.getHeight() / s))
  
  love.graphics.setColor(255, 255, 255)
  displayTransform = love.math.newTransform()
  displayTransform:scale(s)
  displayTransform:translate(dx , dy)

  love.graphics.replaceTransform(displayTransform)
  
	map:draw(dx,dy,s,s)
  --map:box2d_draw()

  love.graphics.replaceTransform(love.math.newTransform())
  love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)

end