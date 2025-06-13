require("/utils/utils")

function ApplyUpdate()
    DownloadFile("https://raw.githubusercontent.com/mrborghini/cc-personal-pc/master/setup.lua", "/setup.lua")
    require("/setup")
end

local function main()
    print("Welcome to the update tool")

    print("Are you sure you want to update?")
    write("This will get rid of your current utils folder and alias and setup files (y/n): ")

    local response = read()

    response = string.lower(response)

    if response == "y" or response == "yes" then
        print("Updating...")
        ApplyUpdate()
    else
        print("Update cancelled")
        return
    end
end

main()
