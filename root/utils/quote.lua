-- This program fetches random quotes from https://api.quotable.io/random

function Main()
    local url = "https://api.quotable.io/random"

    -- Fetch
    local request = http.get(url)

    if request == nil then
        print("Failed to fetch " .. url)
        return
    end

    local result = request.readAll()

    request.close()

    local quote = textutils.unserialiseJSON(result)

    term.setTextColor(colors.cyan)
    print(quote.content .. " --" .. quote.author)
    term.setTextColor(colors.white)
end

Main()
