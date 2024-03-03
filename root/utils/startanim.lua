require("/utils/progress")

function Main()
    term.setTextColor(colors.yellow)
    print("Booting up\n")
    -- Show progress bar until it reaches 100%
    term.setTextColor(colors.green)
    for i = 1, 25 do
        ShowProgressBar(i, 25)
        sleep(0.0025) -- Sleep for 2.5 ms
    end
    term.setTextColor(colors.white)
end

Main()
