-- This function will show a progress bar
function ShowProgressBar(done, total)

    -- Check if the amount done is bigger than the total
    if done > total then
        print("The amount of done cannot be bigger than the total amount")
        return
    end
    local length = 16 -- This is the length of the bar
    -- calculate the percentage
    local percentage = math.floor(done / total * 100)
    -- calculate the amount of hashtags based on the percentage
    local num_hashtags = math.floor(length * percentage / 100)
    -- Calculate the amount of dashes
    local num_dashes = length - num_hashtags

    -- Store the final string
    local final_string = ""

    -- Loop over the amount of hashtags and add them to the string
    for _ = 1, num_hashtags do
        final_string = final_string .. "#"
    end

    -- Same thing for the dashes
    for _ = 1, num_dashes do
        final_string = final_string .. "-"
    end

    -- Clear the current line the cursor is on
    term.clearLine()

    -- Store the y axis of the cursor
    local _, y = term.getCursorPos()

    -- Keep the cursor at the beginning of the line at the current height
    term.setCursorPos(1, y)

    -- Show the progress bar
    write("[" .. final_string .. "]")
end
