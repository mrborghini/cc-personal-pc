-- This program fetches random quotes from https://api.quotable.io/random
require("/utils/utils")
local function main()
    local url = "http://" .. SERVER_URL .."/quote"

    -- Fetch
    local err, result = GetRequest(url)
    if err ~= nil then
        print("Failed to fetch quote")
        return
    end

    local quote = textutils.unserialiseJSON(result)

    term.setTextColor(colors.cyan)
    local quoteString = quote.message;

    if arg[1] == "--no-eye-candy" then
        print(quoteString)
    elseif arg[1] == "--faster-eye-candy" then
        local splitQuote = SplitStr(quoteString, " ")
        for i = 1, #splitQuote, 1 do
            write(splitQuote[i] .. " ")
            -- write(split_quote[i] .. " ")
            sleep(0.0005)
        end
        print();
    else
        for i = 1, #quoteString, 1 do
            write(string.sub(quoteString, i, i))
            sleep(0.0005)
        end
        print();
    end

    term.setTextColor(colors.white)
end

main()
