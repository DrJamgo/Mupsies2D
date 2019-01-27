if arg[#arg] == "-debug" then require("mobdebug").start() end

require 'unit'
require 'units/player'

require 'game'

local sti = require "STI/sti"
local utils = require "utils"

displayTransform = love.math.newTransform()

local wx,wy = 0,0
local player

local game

mybutton = 2

function love.load()
  
  game = Game()
  game:enter()
 
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
  game:mousemoved(x, y, dx, dy, istouch, mybutton)
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end