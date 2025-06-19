-- This function will show a progress bar
local function showProgressBar(done, total, message)
    -- Check if the amount done is bigger than the total
    if done > total then
        print("The amount of done cannot be bigger than the total amount")
        return
    end
    local length = 16 -- This is the length of the bar
    -- calculate the percentage
    local percentage = math.ceil(done / total * 100)
    -- calculate the amount of hashtags based on the percentage
    local numHashtags = math.floor(length * percentage / 100)
    -- Calculate the amount of dashes
    local numDashes = length - numHashtags

    -- Store the final string
    local finalString = ""

    -- Loop over the amount of hashtags and add them to the string
    for _ = 1, numHashtags do
        finalString = finalString .. "#"
    end

    -- Same thing for the dashes
    for _ = 1, numDashes do
        finalString = finalString .. "-"
    end

    -- Clear the current line the cursor is on
    term.clearLine()

    -- Store the y axis of the cursor
    local _, y = term.getCursorPos()

    -- Keep the cursor at the beginning of the line at the current height
    term.setCursorPos(1, y)

    local progressString = string.format("[%s] %d%%", finalString, percentage)

    if message ~= nil then
        progressString = string.format("%s %s", progressString, message)
    end

    -- Show the progress bar
    write(progressString)
end

-- This will download all the files from the root folder
local function fetchApi(url)
    local request = http.get(url)
    if request == nil then
        print("Was unable to fetch: " .. url)
        return
    end

    local jsonText = request.readAll()

    local result = textutils.unserialiseJSON(jsonText)
    -- print(result) -- For debugging purposes
    return result
end

local function downloadFile(url, directory)
    local filename = url:match("([^/]+)$")

    if directory == nil then
        directory = "./"
    end

    local request = http.get(url)

    if request then
        local file = fs.open(directory .. "/" .. filename, "w")
        file.write(request.readAll())

        file.close()
    end
end

local function getGitFolder(url, folder)
    local rootFiles = fetchApi(url)

    if rootFiles == nil then
        print("Could not find files in the root of the repo")
        return
    end

    for i = 1, #rootFiles do
        local file = rootFiles[i]["download_url"]

        -- print(file) -- for debugging purposes

        -- Download the file is the link is not nil
        if file ~= nil then
            downloadFile(file, folder)
        end

        -- Show the progress bar
        showProgressBar(i, #rootFiles)
    end
    print() -- Ad extra line to prevent weird stuff because of the progress bar
end

local function deleteUpdateTool()
    if io.open("/update.lua") ~= nil then
        fs.delete("/update.lua")
    end
    io.close()
end

local function cleanUp()
    fs.delete("/setup.lua")
end

local function main()
    deleteUpdateTool() -- Delete the current update tool if it exists
    local rooturl = "https://api.github.com/repos/mrborghini/cc-personal-pc/contents/root?ref=master"
    local utilsurl = "https://api.github.com/repos/mrborghini/cc-personal-pc/contents/root/utils?ref=master"

    getGitFolder(rooturl)           -- Get the root folder

    fs.makeDir("/utils")        -- Create a utils folder if it doesn't exist

    getGitFolder(utilsurl, "utils") -- Download all the files in the utils folder

    print("\nDone! Please hold Ctrl R or press the restart button")

    cleanUp() -- Remove the setup script
    os.reboot()
end

main()
