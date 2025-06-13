require("/utils/utils")
require("lambo-data-api-types")

local flipped = false
local ws
local channel
local toggleSelf = true

local function connect()
    local url = "ws://" .. SERVER_URL .. "/realtime"
    local retries = 5

    while retries > 0 do
        ws = http.websocket(url)
        if ws then
            return ws
        else
            print("Failed to connect, retrying in 5 seconds...")
            sleep(5)
            retries = retries - 1
        end
    end

    error("Failed to connect after multiple attempts")
end

local function toggleRedstone()
    flipped = not flipped
    for _, side in ipairs({ "back" }) do
        redstone.setOutput(side, flipped)
    end
end

-- Thread 1: Main listener loop
local function listenLoop()
    local wsdata = {
        subscribe = 2,
        metadata = channel
    }
    local wsDataSerialized = textutils.serialiseJSON(wsdata)
    ws.send(wsDataSerialized)

    while true do
        local data = ws.receive()
        print(data)

        if data == nil then
            print("Connection lost")
            ws = connect()
            ws.send(wsDataSerialized)
            goto continue
        end

        local apiResponse = textutils.unserialiseJSON(data)
        if SubscriptionEvent[apiResponse["subscription_type"]] ~= "chat" then
            goto continue
        end

        if apiResponse["message"] == "toggle" then
            toggleRedstone()
        end

        ::continue::
    end
end

-- Thread 2: Redstone monitoring loop
local function redstoneMonitorLoop()
    local previousState = {
        back = false, top = false, left = false,
        right = false, bottom = false, front = false
    }

    while true do
        for _, side in ipairs({ "back", "top", "left", "right", "bottom", "front" }) do
            local currentState = redstone.getInput(side)
            if currentState and not previousState[side] then
                -- Rising edge detected
                local message = {
                    subscribe = 3,
                    metadata = channel .. ":toggle"
                }
                ws.send(textutils.serialiseJSON(message))
                print("Toggling...")
                if toggleSelf then
                    toggleRedstone()
                end
            end
            previousState[side] = currentState
        end
        sleep(0.1) -- shorter sleep to improve responsiveness
    end
end


-- Main entry
local function main()
    channel = arg[1]

    if channel == nil then
        print("Please provide a channel name at the end of the command.")
        return
    end

    ws = connect()

    parallel.waitForAny(listenLoop, redstoneMonitorLoop)
end

main()
