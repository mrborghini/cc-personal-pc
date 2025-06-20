require("/utils/utils")
require("turtle-base-functions")

local function showProgressMessage(minedBlocks, totalBlocks)
    ShowProgressBar(minedBlocks, totalBlocks, string.format("%d/%d", minedBlocks, totalBlocks))
end

local function main()
    local areaStr = arg[1]
    local depthStr = arg[2]

    if areaStr == nil or depthStr == nil then
        print(
            "Mines an area completely. Area means 'width' and 'length'. 'depth' is how deep. Please note you must use a mining turtle.")
        print("Usage: mine area depth")
        return
    end

    if turtle == nil then
        print("This is not a mining turtle")
        return
    end

    if Bot.currentFuel() == 0 then
        print("No fuel :(")
        return
    end

    local area = tonumber(areaStr)
    local depth = tonumber(depthStr)

    local minedBlocks = 0
    local totalBlocks = area * area * depth

    if totalBlocks > Bot.currentFuel() then
        print("Not enough fuel for that area :(")
        print(string.format("You need %d fuel, but you have %d", totalBlocks, Bot.currentFuel()))
        return
    end

    showProgressMessage(minedBlocks, totalBlocks)

    for i = 1, depth, 1 do
        showProgressMessage(minedBlocks, totalBlocks)
        for j = 1, area, 1 do
            showProgressMessage(minedBlocks, totalBlocks)

            for _ = 1, area - 1, 1 do
                showProgressMessage(minedBlocks, totalBlocks)
                Bot.moveForward()
                minedBlocks = minedBlocks + 1
            end

            -- Move right if it's even and left if it's uneven
            if j < area then
                if j % 2 == 0 then
                    Bot.lookRight()
                    Bot.moveForward()
                    minedBlocks = minedBlocks + 1
                    Bot.lookRight()
                else
                    Bot.lookLeft()
                    Bot.moveForward()
                    minedBlocks = minedBlocks + 1
                    Bot.lookLeft()
                end
            end
        end

        if i < depth then
            Bot.moveDown()
            -- This is to fix the bot from going the wrong direction if the area is a odd number`
            if area % 2 == 1 then
                Bot.turnAround()
                for _ = 1, area - 1 do
                    Bot.moveForward()
                end
            end
            Bot.lookLeft()
            minedBlocks = minedBlocks + 1
            showProgressMessage(minedBlocks, totalBlocks)
        end
        showProgressMessage(minedBlocks, totalBlocks)
    end
    Bot.lookLeft() -- Turn again to make it easier to mine again
    minedBlocks = minedBlocks + 1
    showProgressMessage(minedBlocks, totalBlocks)
    print()
    print("Done mining")
end

main()
