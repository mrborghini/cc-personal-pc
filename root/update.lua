require("/utils/downloadfile")

function DeleteCurrent()
    -- All the files in the root that need to be removed
    local files = { "/startup.lua", "/alias.lua" }
    local directory = "/utils"

    fs.delete("rm " .. directory) -- Remove directory

    -- Remove the files in the root
    for i = 1, #files do
        fs.delete(files[i])
    end
end

function ApplyUpdate()
    DownloadFile("https://raw.githubusercontent.com/lamborghinigamer1/cc-personal-pc/master/setup.lua", "/")
    print("Waiting 5 seconds")
    shell.openTab("/setup")
    shell.exit()
end

function Main()
    print("Welcome to the update tool")

    print("Are you sure you want to update?")
    write("This will get rid of your current utils folder and alias and setup files (y/n): ")

    local response = read()

    response = string.lower(response)

    if response == "y" or response == "yes" then
        print("Updating...")
        DeleteCurrent()
        ApplyUpdate()
    else
        print("Update cancelled")
        return
    end
end

Main()
