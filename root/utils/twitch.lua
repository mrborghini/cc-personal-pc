local function main()
    local url = "http://opportunities-dt.gl.at.ply.gg:20913/realtime"
    local ws = assert(http.websocket(url))

    local username = arg[1]

    if username == nil or username == "" then
        print("Please provide a twitch username")
        return
    end

    local wsdata = {
        subscribe = 1,
        metadata = username
    }

    print(textutils.serialiseJSON(wsdata))
    ws.send(wsdata)

    local colors = {}
    for key in pairs(colors) do
        table.insert(colors, key)
    end
    local users = {}


    while true do
        local data, _ = ws.receive()
        local twitch_message = textutils.unserialiseJSON(data)

        local color = colors.red
        local found = false
        for i = 1, #users, 1 do
            if twitch_message.user == users[i] then
                found = true
                color = users[i].color
            end
        end

        if not found then
            color = colors[math.random(#colors)]
            table.insert(users, {
                user = twitch_message.user,
                color = color
            })
        end

        term.setTextColor(color)
        write(twitch_message.user)
        term.setTextColor(colors.white)
        write(": " .. twitch_message.message)
    end
end

main()
