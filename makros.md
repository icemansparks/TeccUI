# moonglow
/run i=0 m=0 c=CastSpellByName while not (GetPlayerBuff(i)==-1) do if (strfind(GetPlayerBuffTexture(GetPlayerBuff(i)),"Spell_Nature_NaturesBlessing")) then m=1 end i=i+1 end if m==0 then c("Healing Touch(Rank 2)") else c("Healing Touch(Rank 3)") end

/run 
i=0 
m=0 
c=CastSpellByName 

while not (GetPlayerBuff(i)==-1) do 
    if (
        strfind(GetPlayerBuffTexture(GetPlayerBuff(i))
        ,"Spell_Nature_NaturesBlessing")
        )
    then
        m=1
    end
    i=i+1
end 

if m==0 then 
    c("Healing Touch(Rank 2)")
else 
    c("Healing Touch(Rank 3)")
end


## rejuvenation override prevention

/run m=0 for i=1,40 do if(strfind(tostring(UnitBuff("target",i)),"Spell_Nature_Rejuvenation"))then m=1 end end if m==0 then CastSpellByName("Rejuvenation(Rank 10)") end


## innervate override prevention

/run n=0 for i=1,40 do if(strfind(tostring(UnitBuff("target",i)),"Spell_Nature_Lightning"))then n=1 end end if n==0 then CastSpellByName("Innervate")end
