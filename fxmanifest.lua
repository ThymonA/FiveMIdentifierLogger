fx_version 'adamant'

game 'gta5'

description 'Identifier logger created by Tigo#9999'
name 'FiveM Identifier Logger'
author 'TigoDevelopment'
contact 'me@tigodev.com'
version '1.0.1'

server_only 'yes'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'locale.lua',
    'locales/nl.lua',
    'locales/en.lua',
    'config.lua',
    'server/main.lua',
}

dependencies {
    'mysql-async'
}
