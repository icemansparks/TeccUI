SLASH_GETGUID1 = "/guid"
SLASH_GETRAIDGUID1 = "/guidraid"

function spairs(t, order)
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

function Slash.CmdList.GETGUID.getPlayerGuid()
    print(string.sub(UnitGUID(PlayerName), -8))
end


function Slash.CmdList.GETRAIDGUID.getLowestGuid()
    tankbuddy="[Lowest GUID]: ";

    -- table initialization
    members = {}

    for i=1,GetNumGroupMembers() do
        
        -- init vars
        pname,pguid=nil
            
        -- get player name
        pname=UnitName('raid'..i)

        -- get guid by playername
        -- Player-Server-GUID
        -- substring needed (last 8 characters)
        -- string.sub("Hello Lua user", -8) 
        pguid=tonumber(string.sub(UnitGUID(pname), -8),16)

        -- write guid to table
        members[i]= pguid
        
    end;

    -- this uses an custom sorting function ordering by score descending
    for k,v in spairs(members, function(t,a,b) return t[b] < t[a] end) do
        print(k,v)
    end

    -- only max or min value
    local key, min = 1, members[1]
    for k, v in ipairs(members) do
        if members[k] < min then
            key, min = k, v
        end
    end

    print(key, min)
    buddyid=min

    print(tankbuddy..buddyid.." - "..pname)
end
