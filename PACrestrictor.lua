require("mysqloo")

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
    print( "Connection faied!")
    print( err )
end

hook.Add("Initialize", "DatabaseStuff", function( )
    db:connect()
    checktable()
end )

local q = db:query("CREATE TABLE IF NOT EXISTS PAC_whitelist ( ID INTEGER, STEAMIDsql TEXT) ")

function q:onSucess(data)
    print "Success!"
end

function q:onError(err)
    print ("Error occured! :" .. err)
end

q:start()
--[[
function checktable()

    local q = db:query("CREATE TABLE IF NOT EXISTS PAC_whitelist ( ID INTEGER, STEAMIDsql TEXT) ")

    if ( not db:TableExists("PAC_whitelist")) then
        SQLquery = db:query( "CREATE TABLE PAC_whitelist ( ID INTEGER, SteamIDsql TEXT )" )
        result = db:query(SQLquery)
            if (db:TableExists("PAC_whitelist")) then
                print "Table created"
            else
                print "Error \n"
                print "sql.LastError( result )" "\n"
            end
        end
end
]]--
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