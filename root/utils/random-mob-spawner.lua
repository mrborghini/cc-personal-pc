local function checkIfCommandPc()
    return type(commands) == "table" and type(commands.exec) == "function"
end

local function randomWithPercentage(percentage)
    local randomValue = math.random(1, 100)
    return randomValue <= percentage
end

local function runCommand(command)
    commands.exec(command)
end

local function showOutput(message)
    print(message)
    runCommand("say " .. message)
end

local function eepy(seconds)
    sleep(seconds)
end


Command = {
    commandString = "",
    chanceInPercentage = 0.0
}

---constructor for Command type
---@param command any
---@param chanceInPercentage any
---@return table
function Command:new(command, chanceInPercentage)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.commandString = command
    obj.chanceInPercentage = chanceInPercentage
    return obj
end

local function main()
    local chanceCommands = {}
    local createdCommands = {}
    local mobs = {
        "allay",
        "axolotl",
        "bat",
        "bee",
        "blaze",
        "camel",
        "cat",
        "cave_spider",
        "chicken",
        "cod",
        "cow",
        "creeper",
        "dolphin",
        "donkey",
        "drowned",
        "elder_guardian",
        "ender_dragon",
        "enderman",
        "endermite",
        "evoker",
        "experience_bottle",
        "experience_orb",
        "fox",
        "frog",
        "ghast",
        "giant",
        "glow_squid",
        "guardian",
        "goat",
        "hoglin",
        "horse",
        "husk",
        "illusioner",
        "iron_golem",
        "llama",
        "magma_cube",
        "mooshroom",
        "mule",
        "ocelot",
        "panda",
        "parrot",
        "phantom",
        "pig",
        "piglin",
        "piglin_brute",
        "pillager",
        "polar_bear",
        "pufferfish",
        "rabbit",
        "ravager",
        "salmon",
        "sheep",
        "shulker",
        "silverfish",
        "skeleton",
        "skeleton_horse",
        "slime",
        "sniffer",
        "snow_golem",
        "spider",
        "squid",
        "stray",
        "strider",
        "tadpole",
        "trader_llama",
        "tropical_fish",
        "turtle",
        "vex",
        "villager",
        "vindicator",
        "warden",
        "witch",
        "wither",
        "wither_skeleton",
        "wolf",
        "zoglin",
        "zombie",
        "zombie_horse",
        "zombie_villager",
        "zombified_piglin" }

    for i = 1, #mobs, 1 do
        table.insert(createdCommands, "summon " .. mobs[i] .. " ~30 ~ ~")
    end

    showOutput("Showing all mobs and their odds...")
    eepy(3)

    for i = 1, #createdCommands, 1 do
        local randomPercentage = math.random(0, 100)
        local cmd = Command:new(createdCommands[i], randomPercentage)
        table.insert(chanceCommands, cmd)
        showOutput(mobs[i] .. ": " .. randomPercentage .. "%")
    end


    for i = 3, 1, -1 do
        showOutput("Starting in " .. i)
        eepy(1)
    end

    showOutput("GOODLUCK!")

    local mobCounts = {}
    local maxMobs = 500


    local looped = 0
    while looped < maxMobs do
        for j = 1, #mobs, 1 do
            print(looped > maxMobs)
            if looped > maxMobs then
                break
            end
            local mob = mobs[j]
            if randomWithPercentage(chanceCommands[j].chanceInPercentage) then
                showOutput("Spawned " .. mob .. " (" .. looped .. "/" .. maxMobs .. ")")
                _, _ = runCommand(chanceCommands[j].commandString)
                mobCounts[mob] = mobCounts[mob] or { count = 0, percentage = 0 }
                mobCounts[mob].count = mobCounts[mob].count + 1
                mobCounts[mob].percentage = chanceCommands[j].chanceInPercentage
                looped = looped + 1
            end
        end
    end

    -- Display mob counts
    showOutput("Mob Counts:")
    local mostSpawns = {
        count = 0,
        mob = "",
        percentage = 0
    }

    for mob, data in pairs(mobCounts) do
        local count = data.count
        local percentage = data.percentage
        showOutput(mob .. ": Count: " .. count .. " (" .. percentage .. "%)")
        if count > mostSpawns.count then
            mostSpawns.mob = mob
            mostSpawns.count = count
            mostSpawns.percentage = percentage
        end
    end

    showOutput(mostSpawns.mob .. " spawned the most with " .. mostSpawns.count .. " (" .. mostSpawns.percentage .. "%)")
end

-- Logic for checking certain information
if not checkIfCommandPc() then
    print("Sorry this is not a command pc. Please use /give @s computercraft:computer_command.")
    return
end

write("This will break your world by spawning a lot of mobs. Are you sure? (y/n): ")

local response = read()

response = string.lower(response)

if response ~= "y" and response ~= "yes" then
    print("Cancelled")
    return
end

write("Are you 100% sure? (y/n): ")

local confirmation = read()

confirmation = string.lower(confirmation)

if confirmation ~= "y" and confirmation ~= "yes" then
    print("Cancelled")
    return
end

while true do
    runCommand("weather thunder 120s")
    main()
    showOutput("Restarting in 5 minutes :)")

    eepy(220)
    showOutput("1 minute :)")

    eepy(30)
    showOutput("30 seconds :D")

    eepy(20)
    showOutput("10 seconds")

    eepy(7)

    for i = 3, 1, -1 do
        showOutput(i)
        eepy(1)
    end

    showOutput("RESTARTING MHUAHAHAHA")
end
