FIL            = {}
FIL.MySQLRady  = false

MySQL.ready(function()
    FIL.MySQLRady = true
end)

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
    FIL.PlayerConnecting(source, setCallback, deferrals)
end)

FIL.PlayerConnecting = function(playerId, setCallback, deferrals)
    local mySqlState = FIL.MySQLRady

    deferrals.defer()
    deferrals.update(_U('updating_information', Config.Name))

    Citizen.Wait(100)

    if (not mySqlState) then
        deferrals.update(_U('waiting_information', Config.Name))
    end

    while not FIL.MySQLRady do
        Citizen.Wait(10)
    end

    if (FIL.MySQLRady and not mySqlState) then
        deferrals.update(_U('updating_information', Config.Name))

        Citizen.Wait(100)
    end

    local name = GetPlayerName(playerId) or 'Unknown'
    local identifiers, steamIdentifier = GetPlayerIdentifiers(playerId) or {}

    local license = nil
    local xbl = nil
    local live = nil
    local discord = nil
    local fivem = nil
    local ip = nil

    for _, identifier in pairs(identifiers) do
        if (string.match(string.lower(identifier), 'steam:')) then
            steamIdentifier = identifier
        elseif (string.match(string.lower(identifier), 'license:')) then
            license = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'xbl:')) then
            xbl = string.sub(identifier, 5)
        elseif (string.match(string.lower(identifier), 'live:')) then
            live = string.sub(identifier, 6)
        elseif (string.match(string.lower(identifier), 'discord:')) then
            discord = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'discord:')) then
            discord = string.sub(identifier, 9)
        elseif (string.match(string.lower(identifier), 'fivem:')) then
            fivem = string.sub(identifier, 7)
        elseif (string.match(string.lower(identifier), 'ip:')) then
            ip = string.sub(identifier, 4)
        end
    end

    if (steamIdentifier == nil or steamIdentifier == '' or steamIdentifier == 'none') then
        deferrals.done()
        return
    end

    MySQL.Async.execute("INSERT INTO `user_identifiers` (`id`, `identifier`, `name`, `license`, `xbl`, `live`, `discord`, `fivem`, `ip`, `date`) VALUES (NULL, @identifier, @name, @license, @xbl, @live, @discord, @fivem, @ip, CURRENT_TIMESTAMP)", {
        ['@identifier'] = steamIdentifier,
        ['@name'] = name,
        ['@license'] = license,
        ['@xbl'] = xbl,
        ['@live'] = live,
        ['@discord'] = discord,
        ['@fivem'] = fivem,
        ['@ip'] = ip,
    })

    deferrals.update(_U('updated_information', Config.Name))

    Citizen.Wait(100)

    deferrals.done()
end