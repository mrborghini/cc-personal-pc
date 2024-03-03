require("/utils/progress")

function Main()
    print("Booting up\n")
    -- Show progress bar until it reaches 100%
    for i = 1, 25 do
        ShowProgressBar(i, 25)
		sleep(0.0025) -- Sleep for 2.5 ms
    end
end

Main()
