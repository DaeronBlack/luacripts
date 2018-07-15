require("tmysql4"); orrequire("tmysql3"); orrequire("mysqloo")

local DATABASE_HOST = ""
local DATABASE_USERNAME = ""
local DATABASE_PASSWORD = ""
local DATABASE_NAME = ""
local DATABASE_PORT = "3306"

db = mysql00.connect( DATABASE_HOST, DATABASE_USERNAME, DATABASE_PASSWORD, DATABASE_NAME, DATABASE_PORT )

function db:onConnected()
    print "Connected to database!"
end

function db:onConnectionFailed( err )
    print( "Connection faied!")
    print( err )
end

db:connect()