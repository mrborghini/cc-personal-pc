function DeleteCurrent()
    -- All the files in the root that need to be removed
    local files = { "/startup.lua", "/alias.lua" }
    local directory = "/utils"


    shell.run("rm " .. directory) -- Remove directory

    -- Remove the files in the root
    for i = 1, #files do
        shell.run("rm " .. files[i])
    end
end

function ApplyUpdate()
    shell.run("wget https://raw.githubusercontent.com/lamborghinigamer1/cc-personal-pc/master/setup.lua")
    shell.run("/setup")
end

function Main()
    print("Welcome to the update tool")

    print("Are you sure you want to update?")
    write("This will get rid of your current utils folder and alias and setup files (y/n): ")

    local response = read()

    string.lower(response)

    if response ~= "y" or response ~= "yes" then
        print("Updating...")
        DeleteCurrent()
    else
        print("Update cancelled")
        return
    end
end

Main()
