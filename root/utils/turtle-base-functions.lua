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

-- @return number|string
function Bot.currentFuel()
    return turtle.getFuelLevel()
end

function Bot.place()
    turtle.place()
end

function Bot.goBackwards()
    Bot.lookLeft()
    Bot.lookLeft()
    Bot.moveForward()
    Bot.lookRight()
    Bot.lookRight()
end

function Bot.getSlotsWithSameItem()
    local slots = {}
    local selectedSlot = turtle.getSelectedSlot()
    for i = 1, 16 do
        if i ~= selectedSlot and turtle.compareTo(i) then
            table.insert(slots, i)
        end
    end
    return slots
end

function Bot.transferToSelected(slots)
    local selectedSlot = turtle.getSelectedSlot()
    for _, slot in ipairs(slots) do
        turtle.select(slot)
        turtle.transferTo(selectedSlot)
    end
    turtle.select(selectedSlot)
end
