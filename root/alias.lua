-- Set aliases for the programs
local function main()
    shell.setAlias("cat", "/utils/cat.lua")             -- Fake cat clone
    shell.setAlias("ascii", "/utils/ascii.lua")         -- My logo
    shell.setAlias("quote", "/utils/quote.lua")         -- A random quote
    shell.setAlias("start-anim", "/utils/start-anim.lua") -- Startup animation
    shell.setAlias("update", "/update.lua")             -- Update tool
    shell.setAlias("random-mob-spawner", "/utils/random-mob-spawner.lua")
    shell.setAlias("curl", "/utils/curl.lua")
    shell.setAlias("twitch", "/utils/twitch.lua")
    shell.setAlias("mine", "/utils/mine.lua")
    shell.setAlias("fill-mode", "/utils/fill-mode.lua")
    shell.setAlias("activation-toggle", "/utils/activation-toggle.lua")
end

main()
