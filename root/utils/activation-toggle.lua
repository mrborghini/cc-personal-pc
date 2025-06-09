require("utils")
require("lambo_data_api_types")

local flipped = false

local function connect()
    local url = "ws://" .. SERVER_URL .. "/realtime"
    local ws
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

    redstone.setOutput("back", flipped)
    redstone.setOutput("top", flipped)
    redstone.setOutput("left", flipped)
    redstone.setOutput("right", flipped)
    redstone.setOutput("bottom", flipped)
    redstone.setOutput("front", flipped)
end

local function main()
    local listenerMode = false
    local channel = arg[2]
    if arg[1] == "--listen" then
        listenerMode = true
    end

    if channel == nil then
        print("Please provide a channel name at the end of the command.")
        return
    end

    local ws = connect()

    local wsdata = {
        subscribe = 2,
        metadata = channel
    }
    local wsDataSerialized = textutils.serialiseJSON(wsdata)
    ws.send(wsDataSerialized)

    while true do
        local data, _ = ws.receive()
        print(data)

        if data == nil then
            ws = connect()
            ws.send(wsDataSerialized)
            goto continue
        end

        local api_response = textutils.unserialiseJSON(data)

        if not SubscriptionEvent[api_response.subscription_type] == "chat" then
            goto continue
        end

        if listenerMode then
            toggleRedstone()
        end

        ::continue::
    end
end

main()
