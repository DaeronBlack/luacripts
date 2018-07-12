--
-- Created by IntelliJ IDEA.
-- User: Jorn
-- Date: 12-7-2018
-- Time: 22:26
-- To change this template use File | Settings | File Templates.
--

local list = {
    ["STEAM_0:0:79090065"] = true,
    ["STEAM_0:1:41786132"] = true,
}

hook.Add("PrePACConfigApply", "PACRankRestrict", function(ply)
    if not list[ply:SteamID()] then
        return false, "Insufficient rank to use PAC."
    end
end )

hook.Add( "PrePACEditorOpen", "PACEditorRestrictor", function(ply)
    if not list[ply:SteamID()] then
        return false, "Insufficient rank to use PAC!"
    end
end )