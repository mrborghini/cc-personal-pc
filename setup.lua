function showProgressBar(done, total)
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

-- This will download all the files from the root folder
function FetchApi(url)
    local request = http.get(url)
    if request == nil then
        print("Was unable to fetch: " .. url)
        return
    end

    local json_text = request.readAll()

    local result = textutils.unserialiseJSON(json_text)
    -- print(result) -- For debugging purposes
    return result
end

function DownloadFile(url, folder)
    local filename = url:match("([^/]+)$")
    if folder == nil then
        shell.run("wget " .. url)
    else
        shell.run("wget " .. url .. " " .. folder .. "/" .. filename)
    end
end


function GetGitFolder(url, folder)
    local root_files = FetchApi(url)

    if root_files == nil then
        print("Could not find files in the root of the repo")
        return
    end

    for i = 1, #root_files do
        local file = root_files[i].download_url
        
        -- print(file) -- for debugging purposes

        -- Download the file is the link is not nil
        if file ~= nil then
            DownloadFile(file, folder)
        end

        -- Show the progress bar
        showProgressBar(i, #root_files)
    end
end

function CleanUp()
    shell.run("rm /setup.lua")
end

function Main()
    local rooturl = "https://api.github.com/repos/lamborghinigamer1/cc-personal-pc/contents/root?ref=master"
    local utilsurl = "https://api.github.com/repos/lamborghinigamer1/cc-personal-pc/contents/root/utils?ref=master"

    GetGitFolder(rooturl) -- Get the root folder

    shell.run("mkdir utils") -- Create a utils folder if it doesn't exist

    GetGitFolder(utilsurl, "utils") -- Download all the files in the utils folder

    CleanUp() -- Remove the setup script
end

Main()
