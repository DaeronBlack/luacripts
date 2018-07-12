--
-- Created by IntelliJ IDEA.
-- User: Jorn
-- Date: 11-7-2018
-- Time: 20:40
-- To change this template use File | Settings | File Templates.
--
require("mysqloo")

local DATABASE_HOST = ""
local DATABASE_PORT = 3306
local DATABASE_NAME = ""
local DATABASE_USERNAME = ""
local DATABASE_PASSWORD  = ""

local db = mysqloo.connect(DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT)

function Initialize()
    db:connect()
    checktable()
end

function checktable()if db:DATABASE_CONNECTED and db:TableExists("PAC_whitelist") then

    print "Table exists"
    else
        if ( not db:TableExists("PAC_whitelist")) then
            SQLquery = db:query( "CREATE TABLE PAC_steamid ( ID INTEGER, SteamIDsql TEXT )" )
            result = db:query(SQLquery)
            if (db:TableExists("PAC_steamid")) then
                print "Table created"
            else
                print "Error \n"
                print "sql.LastError( result )" "\n"
            end
        end
    end
end

function check( ply )

    PlayerSID = ply:SteamID()

    result = db:query("SELECT SteamIDsql FROM PAC_whitelist WHERE SteamIDsql = '"..PlayerSID.."'")
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