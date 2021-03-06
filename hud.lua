Hud = {}

function Hud:initLayer(game)
  self.game = game
  self.draw = Hud.draw
  self.update = Hud.update
  self.mousemoved = Hud.mousemoved
end

function Hud:update(dt)
  
end

function Hud:draw()
  
  if love.keyboard.isDown('b') then
    love.graphics.setNewFont(24)
    local displayTransform = love.math.newTransform()
    displayTransform:scale(1 / (self.game.scale or 1))
    love.graphics.replaceTransform(displayTransform)
    
    love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 10)
    
    if self.game.area then
      love.graphics.print("Area : "..tostring(self.game.area.name), 10, 40)
    end
    
    if self.cursor then
      love.graphics.print("Cursor : "..tostring(self.cursor.x).."|"..tostring(self.cursor.y), self.cursor.x, self.cursor.y)
    end
  end
end

function Hud:mousemoved(x, y, dx, dy, istouch , button)
  self.cursor = {x=x,y=y}
  return false
end