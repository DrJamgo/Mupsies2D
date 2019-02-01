SpawnLayer = {}

function SpawnLayer:initLayer(exitname)

  self.spawn = table.find(
    function(o) return o.name == (exitname) and o.type == "exit" end, self.objects)
end