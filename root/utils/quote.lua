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
    local quotestring = quote.content .. " --" .. quote.author;

    if arg[1] ~= "--no-eye-candy" then
        for i = 1, #quotestring, 1 do
            write(string.sub(quotestring, i, i))
            sleep(0.0005)
        end
        print();
    else
        print(quotestring)
    end

    term.setTextColor(colors.white)
end

Main()
