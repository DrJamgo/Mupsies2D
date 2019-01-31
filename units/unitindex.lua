local index = {}
local utils = require 'utils'
  
index.herder = {
  hpmax = 100,
  body = {
    size = 32, strength = 1000, mass = 50,
    melee = { cooldown = 1.0, duration = 0.5, trigger = 0.3, damage = 10, reach = 16 },
    move = { cooldown = 0.2, force = 2000 }
  },
  appearance = { sprite = "herder" }
}

index.mupsine = utils.deepcopy(index.herder)
index.mupsine.appearance.sprite = "mupsine"

index.spider = {
  hpmax = 100,
  body = {
    size = 16, strength = 1000, mass = 20,
    melee = { cooldown = 1.0, duration = 0.5, trigger = 0.3, damage = 5, reach = 8 },
    move = { cooldown = 0.1, force = 1000}
  },
  appearance = { sprite = "spider" }
}

return index