require("/utils/utils")

local function main()
    local err, response = GetRequest(arg[1])
    if err ~= nil then
        print(err)
        return
    end
    print(response)
end

main()
