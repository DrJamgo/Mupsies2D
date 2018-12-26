local lpcsprite = {}

-- size of one sprite batch grid (x and y)
local GRID = 64

-- size of the spritesheets (they are all the same)
local SPRITESHEETWIDTH = 832
local SPRITESHEETHEIGHT = 1344

local dirlookup = {3, 2, 1, 0}
local animations = {}

local function calculateQuads(animation)
  local quads = {}
  for dir = 1, 4 do
    quads[dir] = {}
    for j = 1, animation.frames do
      quads[dir][j] = love.graphics.newQuad(
        (animation.batchoffsetx + (j-1)) * GRID,
        (animation.batchoffsety + dirlookup[dir] ) * GRID,
        GRID, GRID, SPRITESHEETWIDTH, SPRITESHEETHEIGHT)
    end
  end
  
  return quads
end

--
-- STAND
--
animations.stand = {
  cycles = 1.0,
  frames  = 1,
  batchoffsetx = 0,
  batchoffsety = 4 * 2
}
animations.stand.quads = calculateQuads(animations.stand)

--
-- WALK
--
animations.walk = {
  cycles = 2,
  frames = 8,
  batchoffsetx = 1,
  batchoffsety = 4 * 2
}
animations.walk.quads = calculateQuads(animations.walk)

--
-- SLASH
--
animations.slash = {
  cycles = 1,
  frames = 5,
  batchoffsetx = 1,
  batchoffsety = 4 * 3
}
animations.slash.quads = calculateQuads(animations.slash)

--
-- @param animname string name of animation, one of 
--        - stand
--        - walk
--        - slash
--
function lpcsprite.getQuad(animname, dir, time)
  time = time or 0
  if animations[animname].quads then
    local dirindex = 1 + math.floor(((dir or 0) / math.pi * 2 + 0.5) % 4)
    local num = animations[animname].cycles
    local animindex = math.floor(time / num * animations[animname].frames) % animations[animname].frames + 1
    return animations[animname].quads[dirindex][animindex]
  else
    print("animation '" .. animname .. "' not found")
    return nil
  end
end

return lpcsprite