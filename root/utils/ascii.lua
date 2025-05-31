local function show_art(art)
    for i = 1, #art, 1 do
        print(art[i])
        sleep(0.0005)
    end
end

function Main()
    local art = {
        "            _                  _    _      _ ",
        "  _ __  _ _| |__  ___ _ _ __ _| |_ (_)_ _ (_)",
        " | '  \\| '_| '_ \\/ _ \\ '_/ _` | ' \\| | ' \\| |",
        " |_|_|_|_| |_.__/\\___/_| \\__, |_||_|_|_||_|_|",
        "                         |___/               "
    }

    local art_small = {
        "  _               _         ",
        " | |   __ _ _ __ | |__  ___ ",
        " | |__/ _` | '  \\| '_ \\/ _ \\",
        " |____\\__,_|_|_|_|_.__/\\___/"
    }

    local art_smallest = {
        "    _           ",
        "   (_)__ _ _ _  ",
        "   | / _` | ' \\ ",
        "  _/ \\__,_|_||_|",
        " |__/           "
    }

    local width, _ = term.getSize()

    if width >= 45 then
        show_art(art)
    elseif width >= 28 then
        show_art(art_small)
    else
        show_art(art_smallest)
    end
end

Main()
