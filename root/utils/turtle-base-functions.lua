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
