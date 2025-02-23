local function connect()
    local url = "ws://opportunities-dt.gl.at.ply.gg:20913/realtime"
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
    local ws = connect()

    local username = arg[1]

    if username == nil or username == "" then
        print("Please provide a twitch username")
        return
    end

    local wsdata = {
        subscribe = 1,
        metadata = username
    }

    local ws_data_serialized = textutils.serialiseJSON(wsdata)

    ws.send(ws_data_serialized)

    local users = {}
    local selected_colors = {
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
            local twitch_message = textutils.unserialiseJSON(data)

            if twitch_message ~= nil then
                if twitch_message.user ~= nil then
                    local selected_color = selected_colors[1]

                    local found = false
                    for i = 1, #users, 1 do
                        if twitch_message.user == users[i].user then
                            found = true
                            selected_color = users[i].user_color
                        end
                    end

                    if not found then
                        selected_color = selected_colors[math.random(#selected_colors)]
                        table.insert(users, {
                            user = twitch_message.user,
                            user_color = selected_color
                        })
                    end

                    term.setTextColor(selected_color)
                    write(twitch_message.user)
                    term.setTextColor(colors.white)
                    write(": " .. twitch_message.message)
                    print()
                end
            end
        else
            print("Connection lost, attempting to reconnect...")
            ws = connect()
            ws.send(ws_data_serialized)
        end
    end
end

main()
