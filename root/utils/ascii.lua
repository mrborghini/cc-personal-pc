local function showArt(art)
    for i = 1, #art, 1 do
        print(art[i])
        sleep(0.0005)
    end
end

local function main()
    local art = {
        "            _                  _    _      _ ",
        "  _ __  _ _| |__  ___ _ _ __ _| |_ (_)_ _ (_)",
        " | '  \\| '_| '_ \\/ _ \\ '_/ _` | ' \\| | ' \\| |",
        " |_|_|_|_| |_.__/\\___/_| \\__, |_||_|_|_||_|_|",
        "                         |___/               "
    }

    local artSmall = {
        "  _               _         ",
        " | |   __ _ _ __ | |__  ___ ",
        " | |__/ _` | '  \\| '_ \\/ _ \\",
        " |____\\__,_|_|_|_|_.__/\\___/"
    }

    local artSmallest = {
        "    _           ",
        "   (_)__ _ _ _  ",
        "   | / _` | ' \\ ",
        "  _/ \\__,_|_||_|",
        " |__/           "
    }

    local width, _ = term.getSize()

    if width >= 45 then
        showArt(art)
    elseif width >= 28 then
        showArt(artSmall)
    else
        showArt(artSmallest)
    end
end

main()
