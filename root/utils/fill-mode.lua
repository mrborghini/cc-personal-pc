local function main()
    if turtle == nil then
        print("This is not a mining turtle")
        return
    end

    print("refilling...")
    local lastCapacity = turtle.getFuelLevel()
    while turtle.refuel() do
        write("Current level: " .. turtle.getFuelLevel())
        if lastCapacity == turtle.getFuelLevel() then
            break
        end
        lastCapacity = turtle.getFuelLevel()
    end
    print()
    print("No more fuel in slot or max capacity has been reached.")
end

main()
