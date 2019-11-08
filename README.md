# wow_ui
WoW interface



-- What you can do is iterate over the table in some order. The basic pairs gives you no guarantee of the order in which the keys are visited. Here is a customized version of pairs, which I called spairs because it iterates over the table in a sorted order:

function spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end


    if order then
        table.sort(keys, function(a,b) return order(t, a, b) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end


-- Here is an example of use of such function:

HighScore = { Robin = 8, Jon = 10, Max = 11 }

-- basic usage, just sort by the keys
for k,v in spairs(HighScore) do
    print(k,v)
end
--> Jon     10
--> Max     11
--> Robin   8

-- this uses an custom sorting function ordering by score descending
for k,v in spairs(HighScore, function(t,a,b) return t[b] < t[a] end) do
    print(k,v)
end
--> Max     11
--> Jon     10
--> Robin   8
