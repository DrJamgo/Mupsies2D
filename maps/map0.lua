return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 20,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 6,
  nextobjectid = 17,
  properties = {},
  tilesets = {
    {
      name = "tilea4",
      firstgid = 1,
      filename = "tilesets/tilea4.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "tilesets/tilea4.png",
      imagewidth = 512,
      imageheight = 480,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 960,
      tiles = {}
    },
    {
      name = "tilee_",
      firstgid = 961,
      filename = "tilesets/tilee_.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "tilesets/tilee_.png",
      imagewidth = 512,
      imageheight = 512,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 1024,
      tiles = {}
    },
    {
      name = "tilea1_",
      firstgid = 1985,
      filename = "tilesets/tilea1_.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "tilesets/tilea1_.png",
      imagewidth = 512,
      imageheight = 384,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 768,
      tiles = {}
    },
    {
      name = "tilea2",
      firstgid = 2753,
      filename = "tilesets/tilea2.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 32,
      image = "tilesets/tilea2.png",
      imagewidth = 512,
      imageheight = 384,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 768,
      tiles = {}
    }
  },
  layers = {
    {
      type = "objectgroup",
      id = 2,
      name = "objects",
      visible = true,
      opacity = 0.99,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 241.5,
          y = 113.5,
          width = 30.5,
          height = 29.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288.5,
          y = 94,
          width = 31,
          height = 33.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 161,
          y = 0,
          width = 78.5,
          height = 127,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 49.5,
          y = 95,
          width = 63,
          height = 32.5,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 13,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1,
          y = 0.75,
          width = 127.5,
          height = 95,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240.75,
          y = 0,
          width = 78.5,
          height = 95,
          rotation = 0,
          visible = true,
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "polygon",
          x = 112.333,
          y = 176,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 160, y = 0.333333 },
            { x = 160, y = 96 },
            { x = 96, y = 96 },
            { x = 95.6667, y = 65 },
            { x = 64.6667, y = 64 },
            { x = 64, y = 26.6667 },
            { x = 95.3333, y = 26.3333 },
            { x = 101.333, y = 33.3333 },
            { x = 101.667, y = 56 },
            { x = 151.333, y = 55.6667 },
            { x = 152.333, y = 6.66667 },
            { x = -7.33333, y = 6.66667 },
            { x = -7.33333, y = -8.66667 },
            { x = -56.6667, y = -8.66667 },
            { x = -56.3333, y = 41 },
            { x = -9.33333, y = 41 },
            { x = -8.66667, y = 27 },
            { x = -6, y = 25 },
            { x = 30.6667, y = 25 },
            { x = 31.3333, y = 64 },
            { x = 0.333333, y = 64.3333 },
            { x = 0, y = 79.6667 },
            { x = -64, y = 79.6667 },
            { x = -63.6667, y = -15.6667 },
            { x = -0.333333, y = -16 }
          },
          properties = {
            ["collidable"] = true
          }
        },
        {
          id = 16,
          name = "spawn",
          type = "",
          shape = "rectangle",
          x = 151,
          y = 153,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      id = 1,
      name = "ground",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        139, 139, 139, 139, 139, 139, 139, 140, 99, 103, 105, 139, 139, 139, 139, 139, 139, 139, 139, 139,
        171, 171, 171, 43, 106, 107, 44, 172, 98, 98, 137, 107, 107, 107, 44, 171, 171, 171, 171, 171,
        203, 203, 203, 137, 138, 139, 140, 204, 99, 130, 137, 139, 139, 139, 140, 203, 203, 203, 203, 203,
        235, 235, 235, 169, 170, 171, 172, 236, 131, 99, 169, 170, 171, 171, 172, 235, 235, 235, 235, 235,
        267, 267, 267, 201, 202, 203, 235, 268, 131, 131, 201, 202, 203, 203, 204, 267, 267, 267, 267, 267,
        299, 299, 299, 233, 234, 235, 267, 300, 98, 98, 233, 234, 235, 235, 236, 299, 299, 299, 299, 299,
        130, 102, 103, 265, 266, 267, 299, 99, 99, 99, 265, 266, 267, 267, 268, 99, 99, 99, 131, 131,
        98, 134, 135, 297, 298, 299, 300, 131, 131, 131, 297, 298, 299, 299, 300, 99, 131, 131, 130, 131,
        98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 98, 2253, 2254, 2255,
        98, 99, 99, 99, 99, 99, 99, 99, 98, 98, 99, 99, 99, 99, 102, 102, 102, 2285, 2286, 2287,
        98, 98, 99, 65, 66, 67, 68, 98, 130, 98, 99, 131, 131, 102, 134, 134, 134, 2349, 2350, 2319,
        98, 98, 98, 97, 99, 99, 4, 66, 67, 66, 67, 67, 66, 67, 66, 67, 68, 2851, 2851, 2349,
        98, 98, 99, 129, 99, 131, 36, 162, 163, 162, 163, 162, 163, 35, 102, 103, 100, 102, 102, 103,
        98, 98, 99, 161, 162, 163, 164, 194, 195, 195, 195, 195, 195, 129, 130, 102, 132, 134, 134, 135,
        98, 130, 98, 193, 194, 195, 196, 290, 290, 290, 290, 290, 291, 161, 162, 163, 164, 134, 135, 102,
        98, 98, 130, 289, 290, 291, 292, 130, 130, 130, 130, 130, 130, 193, 194, 195, 196, 103, 103, 103,
        98, 130, 98, 130, 130, 130, 130, 130, 130, 130, 130, 130, 130, 289, 290, 291, 292, 135, 135, 135,
        98, 99, 98, 130, 130, 130, 130, 130, 130, 98, 130, 130, 130, 130, 130, 130, 130, 103, 103, 103,
        98, 98, 130, 130, 130, 130, 130, 98, 130, 98, 99, 102, 134, 130, 130, 130, 130, 130, 135, 135,
        130, 130, 130, 130, 130, 98, 98, 130, 130, 98, 98, 102, 102, 103, 102, 134, 134, 135, 98, 130
      }
    },
    {
      type = "tilelayer",
      id = 5,
      name = "objects",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1161, 1162,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1729, 1730, 0, 1193, 1194,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1761, 1762, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 969, 970, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1033, 1034, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1097, 1098, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
