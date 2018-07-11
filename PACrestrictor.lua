--
-- Created by IntelliJ IDEA.
-- User: Jorn
-- Date: 11-7-2018
-- Time: 20:40
-- To change this template use File | Settings | File Templates.
--

local table = {
    ["001"] = "76561198118445858",
    ["002"] = "76561198043837993"
}

function GM:PlayerInitialSpawn(ply)
    if table[[ply:SteamID]] then
        return true
    end
end

--[[
hook.add("SQLCreateTable", "Creating Table", function()
    sql.Query("CREATE TABLE PAC_steamid( ID INTEGER, SteamID TEXT)")
end)

function CheckTable()
    if[sql.Query("SELECT EXISTS(SELECT 1 FROM PAC_steamid WHERE SteamID = data)")]=TRUE then
        return true
    end
end

hook.Add("PrePACConfigApply", "PACRankRestrict", function(ply)
    if not list[ply:SteamID()] = ply:Name() then
        return false,"Insufficient rank to use PAC."
    end
end)

]]--