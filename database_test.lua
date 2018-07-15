require("tmysql4"); orrequire("tmysql3"); orrequire("mysqloo")

local DATABASE_HOST = ""
local DATABASE_USERNAME = ""
local DATABASE_PASSWORD = ""
local DATABASE_NAME = ""
local DATABASE_PORT = "3306"

local multistatements
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

loadSQLmodule()
db = mysql00.connect( DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT )

function db:onConnected()
    print "Connected to database!"
end

function db:onConnectionFailed( err )
    print( "Connection faied!")
    print( err )
end

db:connect()