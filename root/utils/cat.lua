-- This is a clone of cat of GNU.
-- This will only open the file though and print it out
function Main()
    local filepath = arg[1]

    if filepath == nil then
        print("Usage: cat <path>")
        return
    end

    local file = io.open("./" .. filepath)

    if file then
        local content = file:read("*a")
        print(content)
    else
        print("failed to open file")
    end
end

Main()