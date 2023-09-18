fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game 'rdr3'
version '1.0'
author 'Kono'

client_scripts {
    'client/client.lua'
}

server_scripts { 
    'server/server.lua'
}

shared_scripts {
    'config.lua',
    'locale.lua',
    'languages/*.lua'
}
--------------------------------------------------------------------------------------

---------------- Dependencies -------------------------------------------------------
---- What other scripts (if any) does your script depend on. REMOVE THIS IF NONE ----
dependencies {
    'vorp_core',
    'vorp_inventory',
    'vorp_crafting',
    'menuapi'
}