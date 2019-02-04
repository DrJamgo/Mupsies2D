local lpcsprite = {}

-- offsets for facing: right, down, left, up
local dirlookup = {3, 2, 1, 0}
local animations = {}

function lpcsprite.calculateQuads(spritesheet, animation)
  local quads = {}
  local directions = animation.directions or dirlookup
  for dir = 1, #directions do
    quads[dir] = {}
    for j = 1, animation.frames do
      quads[dir][j] = love.graphics.newQuad(
        (animation.batchoffsetx + (j-1)) * spritesheet.gridsize,
        (animation.batchoffsety + directions[dir] ) * spritesheet.gridsize,
        spritesheet.gridsize, spritesheet.gridsize, spritesheet.width, spritesheet.height)
    end
  end
  
  return quads
end


local lpcgen = {
  gridsize = 64,
  width = 832,
  height = 1344,
  center = {32,48},
  animations = {
    cast = {
      frames = 6,
      batchoffsetx = 1,
      batchoffsety = 4 * 0
    },
    thrust = {
      frames = 7,
      batchoffsetx = 1,
      batchoffsety = 4 * 1
    },
    stand = {
      cycles = 1.0,
      frames  = 1,
      batchoffsetx = 0,
      batchoffsety = 4 * 2
    },
    walk = {
      cycles = 2,
      frames = 8,
      batchoffsetx = 1,
      batchoffsety = 4 * 2
    },
    slash = {
      frames = 5,
      batchoffsetx = 1,
      batchoffsety = 4 * 3
    },
    prone = {
      frames  = 6,
      directions = {0},
      batchoffsetx = 0,
      batchoffsety = 4 * 5
    }
  }
}

local lpcspider = {
  gridsize = 64,
  width = 640,
  height = 320,
  center = {32,48},
  animations = {
    stand = {
      cycles = 1.0,
      frames  = 1,
      batchoffsetx = 0,
      batchoffsety = 4 * 0
    },
    walk = {
      cycles = 2,
      frames = 6,
      batchoffsetx = 4,
      batchoffsety = 4 * 0
    },
    slash = {
      frames = 4,
      batchoffsetx = 0,
      batchoffsety = 4 * 0
    },
    prone = {
      frames  = 4,
      directions = {0},
      batchoffsetx = 0,
      batchoffsety = 4 * 1
    }
  }
}

function lpcsprite.draw(sprite, animname, dir, time, x, y, scale)
  local transform = love.math.newTransform(x, y, 0, scale, scale, unpack(lpcgen.center))
  local quad = lpcsprite.getQuad(sprite, animname, dir, time)
  if quad then
    love.graphics.draw(sprite.image, quad, transform)
  else
    love.graphics.print("ERROR", x, y)
  end
end

--
-- @param animname string name of animation, one of
--        - stand
--        - walk
--        - slash
--
function lpcsprite.getQuad(sprite, animname, dir, time)
  time = time or 0
  if sprite.sprites.animations[animname] then
    if not sprite.sprites.animations[animname].quads then
      sprite.sprites.animations[animname].quads = lpcsprite.calculateQuads(sprite.sprites, sprite.sprites.animations[animname])
    end
    
    local animation = sprite.sprites.animations[animname]
    local dirindex = math.min(1 + math.floor(((dir or 0) / math.pi * 2 + 0.5) % 4), #animation.quads)
    local animindex
    if animation.cycles ~= nil then
      animindex = math.floor(time / animation.cycles * animation.frames) % animation.frames + 1
    else
      animindex = math.min(1 + math.floor(time * animation.frames), animation.frames)
    end
    return animation.quads[dirindex][animindex]
  else
    print("animation '" .. animname .. "' not found")
    return nil
  end
end

local spritesIndex = {
  herder = {
    file = "sprites/herder.png",
    sprites = lpcgen,
    draw = lpcsprite.draw
  },
  mupsine = {
    file = "sprites/mupsine.png",
    sprites = lpcgen,
    draw = lpcsprite.draw
  },
  spider = {
    file = "sprites/spider01.png",
    sprites = lpcspider,
    draw = lpcsprite.draw
  }
}

function lpcsprite.getSprite(name)
  if spritesIndex[name] then
    if spritesIndex[name].file and not spritesIndex[name].image then
      spritesIndex[name].image = love.graphics.newImage(spritesIndex[name].file)
    end
  end
  
  return spritesIndex[name]
end

return lpcsprite