local utils = {}

-- from https://stackoverflow.com/questions/15706270/sort-a-table-in-lua
--
-- this uses an custom sorting function ordering by score descending
-- for k,v in spairs(HighScore, function(t,a,b) return t[b] < t[a] end) do
--     print(k,v)
-- end
--> Max     11
--> Jon     10
--> Robin   8
--
function utils.spairs(t, order)
    -- collect the keys
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    -- if order function given, sort by it by passing the table and keys a, b,
    -- otherwise just sort the keys 
    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    -- return the iterator function
    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

-- from https://stackoverflow.com/questions/1283388/lua-merge-tables
--
-- megres two tables into each other and returns result

function utils.merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            utils.merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

-- from http://lua-users.org/wiki/CopyTable

function utils.deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[utils.deepcopy(orig_key)] = utils.deepcopy(orig_value)
        end
        setmetatable(copy, utils.deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


return utils
