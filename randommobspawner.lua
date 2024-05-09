local function randomWithPercentage(percentage)
    local randomValue = math.random(1, 100)
    return randomValue <= percentage
end

local function run_command(command)
    commands.exec(command)
end

local function show_output(message)
    print(message)
    run_command("say " .. message)
end

local function eepy(seconds)
    sleep(seconds)
end


Command = {
    command_string = "",
    chance_in_percentage = 0.0
}

---constructor for Command type
---@param command any
---@param chance_in_percentage any
---@return table
function Command:new(command, chance_in_percentage)
    local obj = {}
    setmetatable(obj, self)
    self.__index = self
    obj.command_string = command
    obj.chance_in_percentage = chance_in_percentage
    return obj
end

function Main()
    local chance_commands = {}
    local created_commands = {}
    local mobs = {
        "bat",
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
        --"ender_dragon",
        "enderman",
        "endermite",
        "evoker",
        "experience_bottle",
        "experience_orb",
        "fox",
        "ghast",
        "giant",
        "guardian",
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
        table.insert(created_commands, "summon " .. mobs[i] .. " ~30 ~ ~")
    end

    show_output("Showing all mobs and their odds...")
    eepy(3)

    for i = 1, #created_commands, 1 do
        local random_percentage = math.random(0, 100)
        local cmd = Command:new(created_commands[i], random_percentage)
        table.insert(chance_commands, cmd)
        show_output(mobs[i] .. ": " .. random_percentage .. "%")
    end


    for i = 3, 1, -1 do
        show_output("Starting in " .. i)
        eepy(1)
    end

    show_output("GOODLUCK!")

    local mobCounts = {}
    local max_mobs = 500


    local looped = 0
    while looped < max_mobs do
        for j = 1, #mobs, 1 do
            print(looped > max_mobs)
            if looped > max_mobs then
                break
            end
            local mob = mobs[j]
            if randomWithPercentage(chance_commands[j].chance_in_percentage) then
                show_output("Spawned " .. mob .. " (" .. looped .. "/" .. max_mobs .. ")")
                _, _ = run_command(chance_commands[j].command_string)
                mobCounts[mob] = mobCounts[mob] or { count = 0, percentage = 0 }
                mobCounts[mob].count = mobCounts[mob].count + 1
                mobCounts[mob].percentage = chance_commands[j].chance_in_percentage
                looped = looped + 1
            end
        end
    end

    -- Display mob counts
    show_output("Mob Counts:")
    local mostSpawns = {
        count = 0,
        mob = "",
        percentage = 0
    }

    for mob, data in pairs(mobCounts) do
        local count = data.count
        local percentage = data.percentage
        show_output(mob .. ": Count: " .. count .. " (" .. percentage .. "%)")
        if count > mostSpawns.count then
            mostSpawns.mob = mob
            mostSpawns.count = count
            mostSpawns.percentage = percentage
        end
    end

    show_output(mostSpawns.mob .. " spawned the most with " .. mostSpawns.count .. " (" .. mostSpawns.percentage .. "%)")
end

while true do
    run_command("weather thunder 120s")
    Main()
    show_output("Restarting in 5 minutes :)")

    eepy(220)
    show_output("1 minute :)")

    eepy(30)
    show_output("30 seconds :D")

    eepy(20)
    show_output("10 seconds")

    eepy(7)

    for i = 3, 1, -1 do
        show_output(i)
        eepy(1)
    end

    show_output("RESTARTING MHUAHAHAHA")
end
