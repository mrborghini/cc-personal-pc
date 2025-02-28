local function main()
    if turtle == nil then
        print("This is not a mining turtle")
        return
    end

    print("refilling...")
    local last_capacity = turtle.getFuelLevel()
    while turtle.refuel() do
        write("Current level: " .. turtle.getFuelLevel())
        if last_capacity == turtle.getFuelLevel() then
            break
        end
        last_capacity = turtle.getFuelLevel()
    end
    print()
    print("No more fuel in slot or max capacity has been reached.")
end

main()
