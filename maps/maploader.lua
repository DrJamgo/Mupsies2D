require 'love'

maploader = {}

function drawPolygon(self, displayTransform)
  love.graphics.setColor(unpack(self.color)) -- set the drawing color to grey for the blocks
  love.graphics.polygon("fill", self.body:getWorldPoints(self.shape:getPoints()))
end

function maploader.load(world, map)
  t = {}
  y = 1
  objects = {}
  for line in string.gmatch(map.tiles, "[^%s]+") do
    for x = 1, #line do
        local c = line:sub(x,x)
        objects[#objects+1] = maploader.addTile(world, x, y, map.index[c])
        
    end
    y = y+1
  end
  return objects
end

function maploader.addTile(world, x, y, tile)
  object = {}
  
  local tilesize = 64
  
  if tile == 'box' then
    x = tilesize * (x-0.5) / 2
    y = tilesize * (y-0.5) / 2
    object.body = love.physics.newBody(world, x, y, "static")
    object.shape = love.physics.newRectangleShape(x, y, tilesize, tilesize)
    object.fixture = love.physics.newFixture(object.body, object.shape, 0) -- A higher density gives it more mass
    object.draw = drawPolygon
    object.color = {0.80, 0.20, 0.20, 0.5}
  end
  
  return object
end