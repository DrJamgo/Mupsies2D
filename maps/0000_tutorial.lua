return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 16,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 17,
  nextobjectid = 12,
  properties = {
    ["safe"] = false
  },
  tilesets = {
    {
      name = "sand",
      firstgid = 1,
      filename = "sand.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 9,
      image = "../assets/lpc-beach-desert/sand.png",
      imagewidth = 288,
      imageheight = 384,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 108,
      tiles = {}
    },
    {
      name = "terrain_atlas",
      firstgid = 109,
      filename = "../assets/lpc_tile_atlas/lpc_tile_atlas.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "../assets/lpc_tile_atlas/terrain_atlas.png",
      imagewidth = 1024,
      imageheight = 1024,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 1024,
      tiles = {}
    },
    {
      name = "beach-desert",
      firstgid = 1133,
      filename = "../assets/lpc-beach-desert/lpc-beach-desert.tsx",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "../assets/lpc-beach-desert/beach-desert.png",
      imagewidth = 1024,
      imageheight = 1024,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 1024,
      tiles = {}
    }
  },
  layers = {
    {
      type = "objectgroup",
      id = 4,
      name = "spawn",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 2,
          name = "start",
          type = "exit",
          shape = "rectangle",
          x = 299,
          y = 471,
          width = 129,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "e",
          type = "exit",
          shape = "rectangle",
          x = 1,
          y = 171,
          width = 63,
          height = 165,
          rotation = 0,
          visible = true,
          properties = {
            ["exit"] = "e",
            ["map"] = "01_oasis"
          }
        },
        {
          id = 8,
          name = "enemy",
          type = "spawn",
          shape = "rectangle",
          x = 188,
          y = 193,
          width = 65,
          height = 67,
          rotation = 0,
          visible = true,
          properties = {
            ["count"] = 2,
            ["unit"] = "spider"
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 8,
      name = "obstacles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 10,
          name = "",
          type = "",
          shape = "polygon",
          x = -1,
          y = 341,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 115, y = 0 },
            { x = 115, y = -21 },
            { x = 116, y = -38 },
            { x = 270, y = -37 },
            { x = 268, y = 170 },
            { x = 511, y = 172 },
            { x = 513, y = 183 },
            { x = 0, y = 184 }
          },
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "polygon",
          x = 0,
          y = 170,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 45, y = -2 },
            { x = 46, y = -95 },
            { x = 107, y = -95 },
            { x = 112, y = 0 },
            { x = 271, y = 0 },
            { x = 271, y = -93 },
            { x = 433, y = -95 },
            { x = 434, y = -25 },
            { x = 401, y = -24 },
            { x = 402, y = 31 },
            { x = 498, y = 30 },
            { x = 500, y = 100 },
            { x = 433, y = 102 },
            { x = 435, y = 224 },
            { x = 494, y = 225 },
            { x = 496, y = 353 },
            { x = 513, y = 353 },
            { x = 512, y = -176 },
            { x = 2, y = -169 }
          },
          properties = {
            ["collidable"] = true
          }
        }
      }
    },
    {
      type = "tilelayer",
      id = 15,
      name = "Tile Layer 2",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 221, 221, 221, 0, 0, 0, 0, 221, 221, 221, 221, 221, 221, 0, 0,
        0, 221, 221, 221, 0, 0, 0, 0, 221, 221, 221, 221, 221, 221, 0, 0,
        0, 221, 221, 221, 0, 0, 0, 0, 221, 29, 29, 29, 221, 0, 0, 0,
        221, 221, 221, 221, 221, 221, 221, 221, 221, 29, 29, 29, 221, 0, 0, 0,
        29, 29, 29, 29, 29, 221, 221, 221, 29, 29, 29, 221, 221, 221, 221, 221,
        29, 29, 29, 29, 29, 221, 221, 221, 29, 29, 29, 221, 221, 221, 221, 221,
        29, 29, 29, 221, 221, 221, 221, 221, 221, 29, 29, 29, 29, 221, 221, 0,
        221, 221, 221, 221, 221, 0, 0, 0, 221, 29, 29, 29, 29, 221, 0, 0,
        221, 221, 221, 221, 0, 0, 0, 0, 221, 29, 29, 29, 221, 221, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 221, 221, 29, 29, 221, 221, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 221, 221, 29, 29, 221, 221, 221, 221,
        0, 0, 0, 0, 0, 0, 0, 0, 221, 221, 29, 29, 29, 29, 221, 221,
        0, 0, 0, 0, 0, 0, 0, 0, 221, 221, 29, 29, 29, 29, 29, 221,
        0, 0, 0, 0, 0, 0, 0, 0, 221, 221, 221, 221, 29, 29, 29, 221
      }
    },
    {
      type = "tilelayer",
      id = 14,
      name = "Tile Layer 1",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 145, 174, 144, 142, 142, 142, 142, 145, 174, 174, 174, 174, 144, 142, 142,
        0, 177, 206, 176, 142, 142, 142, 142, 177, 206, 206, 206, 206, 176, 142, 142,
        0, 209, 238, 208, 142, 142, 142, 142, 209, 238, 238, 238, 238, 208, 142, 142,
        174, 175, 0, 173, 174, 174, 174, 174, 175, 0, 0, 0, 0, 0, 142, 142,
        206, 207, 0, 205, 206, 206, 206, 206, 207, 125, 253, 126, 0, 0, 174, 144,
        238, 239, 0, 237, 238, 238, 238, 238, 239, 222, 188, 158, 205, 206, 206, 176,
        253, 253, 253, 253, 126, 0, 0, 0, 125, 254, 252, 126, 237, 238, 238, 208,
        0, 0, 188, 189, 158, 0, 0, 0, 157, 190, 0, 220, 0, 0, 0, 0,
        189, 189, 158, 0, 0, 0, 0, 0, 0, 222, 29, 252, 126, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 222, 0, 188, 158, 141, 142, 142,
        110, 110, 110, 112, 142, 142, 142, 142, 143, 157, 190, 220, 0, 173, 174, 144,
        142, 142, 142, 142, 142, 142, 142, 142, 143, 0, 222, 220, 0, 205, 206, 176,
        142, 142, 142, 142, 142, 142, 142, 142, 143, 0, 222, 220, 0, 237, 238, 208,
        142, 142, 142, 142, 142, 142, 142, 142, 143, 0, 222, 252, 253, 126, 0, 141,
        142, 142, 142, 142, 142, 142, 142, 142, 143, 0, 157, 189, 190, 252, 126, 141,
        142, 142, 142, 142, 142, 142, 142, 142, 143, 0, 0, 0, 222, 0, 220, 141
      }
    },
    {
      type = "objectgroup",
      id = 12,
      name = "units",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {}
    },
    {
      type = "tilelayer",
      id = 16,
      name = "After",
      x = 0,
      y = 0,
      width = 16,
      height = 16,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        142, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 109, 112, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 173, 174, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 109, 110, 112,
        0, 0, 0, 109, 110, 110, 110, 110, 111, 0, 0, 0, 0, 141, 142, 142,
        0, 0, 0, 141, 142, 142, 142, 142, 143, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
