require("/utils/utils")
require("turtle-base-functions")

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

    ShowProgressBar(minedBlocks, totalBlocks)

    for i = 1, depth, 1 do
        ShowProgressBar(minedBlocks, totalBlocks)
        for j = 1, area, 1 do
            ShowProgressBar(minedBlocks, totalBlocks)
            for y = 1, area - 1, 1 do
                ShowProgressBar(minedBlocks, totalBlocks)
                Bot.moveForward()
                minedBlocks = minedBlocks + 1
            end

            if j == area then
                goto continue
            end

            -- Move right if it's even and left if it's uneven
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
            ::continue::
        end

        if depth == i then
            goto continue
        end
        Bot.moveDown()
        minedBlocks = minedBlocks + 1
        Bot.lookLeft()
        ShowProgressBar(minedBlocks, totalBlocks)
        ::continue::
    end
    Bot.lookLeft() -- Turn again to make it easier to mine again
    minedBlocks = minedBlocks + 1
    ShowProgressBar(minedBlocks, totalBlocks)
    print()
    print("Done mining")
end

main()
