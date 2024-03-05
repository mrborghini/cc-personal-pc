-- This program will fetch apis

function FetchApi(url)
    local request = http.get(url)

    if request == nil then
        print("Failed to fetch " .. url)
        return
    end

    local result = request.readAll()

    request.close()

    return result
end
