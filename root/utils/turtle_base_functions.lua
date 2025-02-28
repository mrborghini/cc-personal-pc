function MoveUp()
    turtle.digUp()
    turtle.up()
end

function MoveDown()
    turtle.digDown()
    turtle.down()
end

function MoveForward()
    turtle.dig()
    turtle.forward()
end

function LookRight()
    turtle.turnRight()
end

function LookLeft()
    turtle.turnLeft()
end

-- @return number|string
function CurrentFuel()
    return turtle.getFuelLevel()
end

-- @param current number
-- @param total number
-- @returns void
function ProgressBar(current, total)
    local bar_Length = 16
    local percentage = current / total * 100

    local dashes = math.floor(bar_Length * (percentage / 100))
    local tags = bar_Length - dashes

    local progress_bar_string = "["
    for _ = 1, dashes do
        progress_bar_string = progress_bar_string .. "#"
    end

    for _ = 1, tags do
        progress_bar_string = progress_bar_string .. "-"
    end

    progress_bar_string = progress_bar_string .. "]"
    progress_bar_string = progress_bar_string .. "(" .. current .. "/" .. total .. ") " .. math.floor(percentage) .. "%"
    local _, y = term.getCursorPos()
    term.setCursorPos(1, y)
    write(progress_bar_string)
end
