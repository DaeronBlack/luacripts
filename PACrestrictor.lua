require("mysqloo")
-- TODO
-- Make it so superadmins can add users with command in-game
-- Superadmins can remove aswell ^
--

local DATABASE_HOST = ""
local DATABASE_USERNAME = ""
local DATABASE_PASSWORD = ""
local DATABASE_NAME = ""
local DATABASE_PORT = "3306"

db = mysqloo.connect( DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT )

function db:onConnected()
    print "Connected to database!"
end

function db:onConnectionFailed( err )
    print( "Connection failed!")
    print( err )
end

hook.Add("Initialize", "DatabaseStuff", function( )
    db:connect()
end )

local q = db:query("CREATE TABLE IF NOT EXISTS PAC_whitelist ( ID INTEGER, STEAMIDsql TEXT NOT NULL) ")
q:start()
function q:onSuccess()
    print("Table created!")

end )

hook.Add("PrePACConfigApply", "PACRankRestrict", function(ply)
    
    steamID = ply:SteamID()

    local query1 = db:query("SELECT STEAMIDsql FROM PAC_whitelist WHERE STEAMIDsql = '"..db:escape(steamID)"'" )
    query1:start()
    function query1:onSuccess()
        print("Query successfull!")
    end
    if (query1) then --check[ply:SteamID()] then
        db_value_ID( ply )
         return true -- false, "You are not whitelisted to use PAC!"
    end
end )

hook.Add( "PrePACEditorOpen", "PACEditorRestrictor", function(ply)
    if not db_value_ID( ply ) --check[ply:SteamID()] then
    then
        return false, "You are not whitelisted to use PAC!"
    end
end )
