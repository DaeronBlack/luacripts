--
-- Created by IntelliJ IDEA.
-- User: Jorn
-- Date: 11-6-2018
-- Time: 20:07
-- To change this template use File | Settings | File Templates.
--

function GODMODE( ply, dmginfo) if(ply:GetNWInt("GOD") == 1) then
    dmginfo:ScaleDamage(0)
end

    hook.Add("EntityTakeDamage", "GODMODE", GODMODE)
end

hook.add("PhysgunDrop", "ply_physgunfreeze", function(pl, ent)
    hook.Remove("PhysgunDrop", "ulxPlayerDrop")

    ent._frozen = false if( ent:IsPlayer()) then
    ent.SetMoveType(pl:KeyDown(IN_ATTACK2) and MOVETYPE_NOCLIP or MOVETYPE_WALK)

    if(pl:KeyDown(IN_ATTACK2)) then
        ent:Freeze(true)
        RunCOnsoleCommand( "use", "keys" )
        ent:SetNWInt(GODMODE, 1)
        ent:DisallowSpawning( not should_unfreeze)
        ulx.setNoDie(ent, not should_unfreeze)
    else
        ent:Freeze(false)
        ent:SetNWInt(GODMODE, 0)
        ent:DisallowSpawning(false)
        ulx.setNoDie(ent, should_unfreeze)

    end
    if SERVER then if not ent:Alive() then
        ent:Spawn()
        self:PlayerSpawn(ent)
        ent:SetPos(pl:GetEyeTrace().HitPos)
    end
    end
    return
end
end)

hook.Add("PhysgunPickup", "ply_frozen", function(pl, ent)
    if (ent:IsPlayer() )then
        ent._frozen = true
        RunConsoleCommand( "use", "keys")
    else
        return false
    end
end)

function playerdies( pl, weapon, killer ) if(pl._frozen)then
    return false
else
    return true
end

    hook.Add("CanPlayerSuicide", "playerNoDeath", playerDies)
end
