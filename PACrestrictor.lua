--
-- Created by IntelliJ IDEA.
-- User: Jorn
-- Date: 11-7-2018
-- Time: 20:40
-- To change this template use File | Settings | File Templates.
--

local list = {
    ["STEAM_0:0:79090065"] = true,
    ["STEAM_0:1:41786132"] = true,
}

function Initialize()
    tables_exist()
end

function table_exist()if sql.TableExists("PAC_steamid") then

    print "Tables exist"
    else
        if ( not sql.TableExists("PAC_steamid")) then
            query = "CREATE TABLE PAC_steamid ( ID INTEGER, SteamIDsql TEXT )"
            result = sql.Query(query)
            if (sql.TableExists("PAC_steamid")) then
                print "Table created"
            else
                print "Error \n"
                print "sql.LastError( result )" "\n"
            end
        end
    end
end

function check( ply )

    steamID = ply:SteamID()

    result = sql.Query("SELECT SteamIDsql FROM PAC_steamid WHERE SteamIDsql = '"..steamID.."'")
    if (result) then
        return true
    end
end

hook.Add("PrePACConfigApply", "PACRankRestrict", function(ply)
    if not check == true --check[ply:SteamID()] then
    then
        return false, "Insufficient rank to use PAC."
    end
end )

hook.Add( "PrePACEditorOpen", "PACEditorRestrictor", function(ply)
    if not check == true --check[ply:SteamID()] then
        then
        return false, "Insufficient rank to use PAC!"
    end
end )