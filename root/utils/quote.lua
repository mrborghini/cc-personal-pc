-- This program fetches random quotes from https://api.quotable.io/random
require("/utils/apifetcher")
require("/utils/customsyntax")
function Main()
    local url = "http://api.quotable.io/random"

    -- Fetch
    local result = FetchApi(url)

    local quote = textutils.unserialiseJSON(result)

    term.setTextColor(colors.cyan)
    local quotestring = quote.content .. " --" .. quote.author;

    if arg[1] == "--no-eye-candy" then
        print(quotestring)
    elseif arg[1] == "--faster-eye-candy" then
        local split_quote = SplitString(quotestring, " ")
        for i = 1, #split_quote, 1 do
            write(split_quote[i] .. " ")
            -- write(split_quote[i] .. " ")
            sleep(0.0005)
        end
        print();
    else
        for i = 1, #quotestring, 1 do
            write(string.sub(quotestring, i, i))
            sleep(0.0005)
        end
        print();
    end

    term.setTextColor(colors.white)
end

Main()
