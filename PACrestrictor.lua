local DATABASE_HOST = ""
local DATABASE_PORT = 3306
local DATABASE_NAME = ""
local DATABASE_USERNAME = ""
local DATABASE_PASSWORD  = ""

local multistatements
local MySQLite_config = MySQLite_config or RP_MySQLConfig or FPP_MySQLConfig
local moduleLoaded

local function loadSQLmodule()
    if moduleLoaded or not MySQLite_config or not MySQLite_config.EnableMySQL then return end

    local moo, tmsql= file.Exists("bin/gsmv_mysqloo_*.dll", "LUA"), file.Exists("bin/gsmv_tmysql4_*.dll", "LUA")

    if not moo and not tmsql then
        error("No suitable MySQL Module")
    end
    moduleLoaded = true

    require(moo and tmsql and MySQLite_config.Preferred_module or
        moo and "mysqloo" or
        "tmysql4")

    multistatements = CLIENT_MULTI_STATEMENTS

    mysql00 = mysqloo
    TMySQL = tmysql
end

db = mysql00.connect( DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT )

loadSQLmodule()
module("MySQLite")

function db:onConnected()
    print "Connected to database!"
end

function db:onConnectionFailed( err )
    print( "Connection faied!")
    print( err )
end

db:connect()

hook.Add("Initialize", "DatabaseStuff", function( )
    checktable()
end )

function checktable()if db:TableExists("PAC_whitelist") then

    print "Table exists"
    else
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