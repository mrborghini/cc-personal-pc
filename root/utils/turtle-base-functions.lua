Bot = {}

function Bot.moveUp()
    turtle.digUp()
    turtle.up()
end

function Bot.moveDown()
    turtle.digDown()
    turtle.down()
end

function Bot.moveForward()
    turtle.dig()
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
