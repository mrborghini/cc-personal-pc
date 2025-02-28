require("turtle_base_functions")

local function main()
    local area_str = arg[1]
    local depth_str = arg[2]

    if area_str == nil or depth_str == nil then
        print(
            "Mines an area completely. Area means 'width' and 'length'. 'depth' is how deep. Please note you must use a mining turtle.")
        print("Usage: mine area depth")
        return
    end

    if turtle == nil then
        print("This is not a mining turtle")
        return
    end

    if CurrentFuel() == 0 then
        print("No fuel :(")
        return
    end

    local area = tonumber(area_str)
    local depth = tonumber(depth_str)

    local mined_blocks = 0
    local total_blocks = area * area * depth

    ProgressBar(mined_blocks, total_blocks)

    for i = 1, depth, 1 do
        ProgressBar(mined_blocks, total_blocks)
        for j = 1, area, 1 do
            ProgressBar(mined_blocks, total_blocks)
            for y = 1, area - 1, 1 do
                ProgressBar(mined_blocks, total_blocks)
                MoveForward()
                mined_blocks = mined_blocks + 1
            end

            if j == area then
                goto continue
            end

            -- Move right if it's even and left if it's uneven
            if j % 2 == 0 then
                LookRight()
                MoveForward()
                mined_blocks = mined_blocks + 1
                LookRight()
            else
                LookLeft()
                MoveForward()
                mined_blocks = mined_blocks + 1
                LookLeft()
            end
            ::continue::
        end

        if depth == i then
            goto continue
        end
        MoveDown()
        mined_blocks = mined_blocks + 1
        LookLeft()
        ProgressBar(mined_blocks, total_blocks)
        ::continue::
    end
    LookLeft() -- Turn again to make it easier to mine again
    mined_blocks = mined_blocks + 1
    ProgressBar(mined_blocks, total_blocks)
    print()
    print("Done mining")
end

main()
