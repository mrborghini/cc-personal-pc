Bot = {}

function Bot.moveUp()
    turtle.digUp()
    turtle.up()
end

function Bot.moveDown()
    turtle.digDown()
    turtle.down()
end

local function isIndestructable(name)
    local indestrucatableBlocks = { "minecraft:bedrock", "minecraft:end_portal_frame" }
    for i = 1, #indestrucatableBlocks, 1 do
        if indestrucatableBlocks[i] == name then
            return true
        end
    end
    return false
end

function Bot.moveForward()
    while turtle.detect() do
        local _, data = turtle.inspect()
        if (isIndestructable(data["name"])) then
            turtle.up()
            turtle.forward()
            while turtle.detectDown() do
                local _, blockData = turtle.inspectDown()
                if isIndestructable(blockData["name"]) then
                    Bot.moveForward()
                else
                    break
                end
            end
            turtle.digDown()
            turtle.down()
        end
        turtle.dig()
    end
    turtle.forward()
end

function Bot.lookRight()
    turtle.turnRight()
end

function Bot.lookLeft()
    turtle.turnLeft()
end

function Bot.turnAround()
    turtle.turnLeft()
    turtle.turnLeft()
end

-- @return number|string
function Bot.currentFuel()
    return turtle.getFuelLevel()
end

function Bot.place()
    turtle.place()
end

function Bot.placeBelow()
    turtle.placeDown()
end

function Bot.goBackwards()
    Bot.turnAround()
    Bot.moveForward()
    Bot.turnAround()
end

function Bot.getSlotWithSameItem()
    local selectedSlot = turtle.getSelectedSlot()
    for i = 1, 16 do
        if i ~= selectedSlot and turtle.compareTo(i) then
            return i
        end
    end
    return nil
end

function Bot.transferToSelected(slot)
    if slot == nil then
        print("Warning: You are running out of items to be filling with.")
        return
    end
    local selectedSlot = turtle.getSelectedSlot()
    local firstSlot = slot
    turtle.select(firstSlot)
    turtle.transferTo(selectedSlot)
    turtle.select(selectedSlot)
end
