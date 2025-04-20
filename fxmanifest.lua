fx_version 'cerulean'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game 'rdr3'

description 'btc-wagons'
version '1.0.4'
author 'Betiucia'

shared_scripts {
    '@ox_lib/init.lua',
    'locales/*.lua',
    'shared/*.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

dependencies {
    'ox_lib',
    'btc-redemrp_menu_base',
    'lockpick'
}

files {
	'images/*.png',
}

lua54 'yes'
