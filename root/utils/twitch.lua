require("utils")
require("lambo-data-api-types")

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

local function main()
    local username = arg[1]
    if username == nil or username == "" then
        print("Please provide a twitch username")
        return
    end

    local ws = connect()

    local wsdata = {
        subscribe = 1,
        metadata = username
    }

    local wsDataSerialized = textutils.serialiseJSON(wsdata)

    ws.send(wsDataSerialized)

    local users = {}
    local selectedColors = {
        colors.orange,
        colors.magenta,
        colors.lightBlue,
        colors.yellow,
        colors.lime,
        colors.pink,
        colors.gray,
        colors.lightGray,
        colors.cyan,
        colors.purple,
        colors.blue,
        colors.green,
        colors.red
    }

    print("Successfully connected to ttv/" .. username)

    while true do
        local data, _ = ws.receive()
        if data ~= nil then
            local apiResponse = textutils.unserialiseJSON(data)

            if not SubscriptionEvent[apiResponse["subscription_type"]] == "twitchSubscription" then
                goto continue
            end

            local twitchMessage = textutils.unserialiseJSON(apiResponse["message"])

            if twitchMessage ~= nil then
                if twitchMessage.user ~= nil then
                    local selectedColor = selectedColors[1]

                    local found = false
                    for i = 1, #users, 1 do
                        if twitchMessage.user == users[i].user then
                            found = true
                            selectedColor = users[i].user_color
                        end
                    end

                    if not found then
                        selectedColor = selectedColors[math.random(#selectedColors)]
                        table.insert(users, {
                            user = twitchMessage.user,
                            userColor = selectedColor
                        })
                    end

                    term.setTextColor(selectedColor)
                    write(twitchMessage.user)
                    term.setTextColor(colors.white)
                    write(": " .. twitchMessage.message)
                    print()
                end
            end
        else
            print("Connection lost, attempting to reconnect...")
            ws = connect()
            ws.send(wsDataSerialized)
        end
        ::continue::
    end
end

main()
