-- This is a clone of cat of GNU.
-- This will only open the file though and print it out
function Main()
    -- Get user input
    local filepath = arg[1]

    if filepath == "--help" then
        print("\
        \n\
          -A, --show-all           equivalent to -vET\n\
          -b, --number-nonblank    number nonempty output lines, overrides -n\n\
          -e                       equivalent to -vE\n\
          -E, --show-ends          display $ at end of each line\n\
          -n, --number             number all output lines\n\
          -s, --squeeze-blank      suppress repeated empty output lines\n\
        ")
        print("\
          -t                       equivalent to -vT\n\
          -T, --show-tabs          display TAB characters as ^I\n\
          -u                       (ignored)\n\
          -v, --show-nonprinting   use ^ and M- notation, except for LFD and TAB\n\
        ")
        return
    end

    -- Option flags
    local show_all = false
    local number_nonblank = false
    local show_ends = false
    local number = false
    local squeeze_blank = false
    local show_tabs = false
    local show_nonprinting = false

    -- Parse options
    local i = 1
    while arg[i] do
        if arg[i] == "-A" or arg[i] == "--show-all" then
            show_all = true
        elseif arg[i] == "-b" or arg[i] == "--number-nonblank" then
            number_nonblank = true
        elseif arg[i] == "-e" then
            show_ends = true
        elseif arg[i] == "-E" or arg[i] == "--show-ends" then
            show_ends = true
        elseif arg[i] == "-n" or arg[i] == "--number" then
            number = true
        elseif arg[i] == "-s" or arg[i] == "--squeeze-blank" then
            squeeze_blank = true
        elseif arg[i] == "-t" then
            show_tabs = true
        elseif arg[i] == "-T" or arg[i] == "--show-tabs" then
            show_tabs = true
        elseif arg[i] == "-u" then
            -- Ignored
        elseif arg[i] == "-v" or arg[i] == "--show-nonprinting" then
            show_nonprinting = true
        else
            filepath = arg[i] -- Assume it's a file path
        end
        i = i + 1
    end

    if filepath == nil then
        while true do
            local input = read()
            print(input)
        end
    end

    local file = io.open(filepath)

    if file then
        local content = file:read("*a")
        -- Apply options if set
        if show_all then
            content = content:gsub("\n", "\n$"):gsub("\t", "^I")
        end
        if number_nonblank then
            content = content:gsub("([^\n])\n", "%1\n\n"):gsub("\n\n", "\n"):gsub("\n", "\n     ")
        end
        if show_ends then
            content = content:gsub("\n", "$\n")
        end
        if number then
            local line_count = 1
            content = content:gsub("([^\n]*)\n", function(line)
                local num = string.format("\n%6d", line_count)
                line_count = line_count + 1
                return num.." "..line
            end)
        end
        if squeeze_blank then
            content = content:gsub("\n\n+", "\n")
        end
        if show_tabs then
            content = content:gsub("\t", "^I")
        end
        if show_nonprinting then
            content = content:gsub("[\128-\255\001-\008\014-\031\127]", function(c)
                return string.format("^%c", c:byte(1))
            end)
        end
        print(content)
        file:close()
    else
        print("Failed to open file")
    end
end

Main()
