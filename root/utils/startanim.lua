require("/utils/progress")

function Main()
    term.setTextColor(colors.yellow)
    local message = "Booting up\n"

    for i = 1, #message, 1 do
        write(string.sub(message, i, i))
        sleep(0.05)
    end
    print();
    -- Show progress bar until it reaches 100%
    term.setTextColor(colors.green)
    for i = 1, 25 do
        ShowProgressBar(i, 25)
        sleep(0.0025) -- Sleep for 2.5 ms
    end
    term.setTextColor(colors.white)
end

Main()
