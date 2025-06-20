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
            "fills an area completely. Area means 'width' and 'length'. 'depth' is how deep. Please note you must use a mining turtle.")
        print("Usage: fill area depth")
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

    local placedBlocks = 0
    local totalBlocks = area * area * depth

    if totalBlocks > Bot.currentFuel() then
        print("Not enough fuel for that area :(")
        print(string.format("You need %d fuel, but you have %d", totalBlocks, Bot.currentFuel()))
        return
    end

    Bot.turnAround()

    for i = 1, depth do
        showProgressMessage(placedBlocks, totalBlocks)

        for j = 1, area do
            showProgressMessage(placedBlocks, totalBlocks)

            for y = 1, area - 1 do
                local slot = Bot.getSlotWithSameItem()
                Bot.transferToSelected(slot)

                showProgressMessage(placedBlocks, totalBlocks)
                Bot.goBackwards()
                Bot.place()
                placedBlocks = placedBlocks + 1
            end

            if j < area then
                if j % 2 == 0 then
                    Bot.lookRight()
                    Bot.goBackwards()
                    Bot.place()
                    Bot.lookRight()
                else
                    Bot.lookLeft()
                    Bot.goBackwards()
                    Bot.place()
                    Bot.lookLeft()
                end
                placedBlocks = placedBlocks + 1
            end
        end

        if i < depth then
            Bot.moveUp()

            Bot.placeBelow()
            -- This is to fix the bot from going the wrong direction if the area is a odd number
            if area % 2 == 1 then
                Bot.turnAround()
                for i = 1, area - 1 do
                    Bot.goBackwards()
                end
            end
            Bot.lookLeft()
            placedBlocks = placedBlocks + 1
            showProgressMessage(placedBlocks, totalBlocks)
        end
    end

    Bot.lookLeft()
    placedBlocks = placedBlocks + 1
    showProgressMessage(placedBlocks, totalBlocks)
    print()
    print("Done mining")
end

main()
