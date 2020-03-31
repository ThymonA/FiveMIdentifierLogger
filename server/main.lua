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
            if (Config.RemoveIdentifierPrefix) then license = string.sub(identifier, 9) else license = identifier end
        elseif (string.match(string.lower(identifier), 'xbl:')) then
            if (Config.RemoveIdentifierPrefix) then xbl = string.sub(identifier, 5) else xbl = identifier end
        elseif (string.match(string.lower(identifier), 'live:')) then
            if (Config.RemoveIdentifierPrefix) then live = string.sub(identifier, 6) else live = identifier end
        elseif (string.match(string.lower(identifier), 'discord:')) then
            if (Config.RemoveIdentifierPrefix) then discord = string.sub(identifier, 9) else discord = identifier end
        elseif (string.match(string.lower(identifier), 'fivem:')) then
            if (Config.RemoveIdentifierPrefix) then fivem = string.sub(identifier, 7) else fivem = identifier end
        elseif (string.match(string.lower(identifier), 'ip:')) then
            if (Config.RemoveIdentifierPrefix) then ip = string.sub(identifier, 4) else ip = identifier end
        end
    end

    if (steamIdentifier == nil or steamIdentifier == '' or steamIdentifier == 'none') then
        deferrals.done()
        return
    end

    local identifiersExists = false

    if (Config.AddNewIdentifiersOnly) then
        local queryParams = {
            ['@identifier'] = steamIdentifier
        }

        local query = 'SELECT COUNT(*) AS `count` FROM `user_identifiers` WHERE `identifier` = @identifier'

        if (license == nil) then
            query = query .. ' AND `license` IS NULL'
        else
            query = query .. ' AND `license` = @license'
            queryParams['license'] = license
        end

        if (xbl == nil) then
            query = query .. ' AND `xbl` IS NULL'
        else
            query = query .. ' AND `xbl` = @xbl'
            queryParams['xbl'] = xbl
        end

        if (live == nil) then
            query = query .. ' AND `live` IS NULL'
        else
            query = query .. ' AND `live` = @live'
            queryParams['live'] = live
        end

        if (discord == nil) then
            query = query .. ' AND `discord` IS NULL'
        else
            query = query .. ' AND `discord` = @discord'
            queryParams['discord'] = discord
        end

        if (fivem == nil) then
            query = query .. ' AND `fivem` IS NULL'
        else
            query = query .. ' AND `fivem` = @fivem'
            queryParams['fivem'] = fivem
        end

        if (ip == nil) then
            query = query .. ' AND `ip` IS NULL'
        else
            query = query .. ' AND `ip` = @ip'
            queryParams['ip'] = ip
        end

        MySQL.Async.fetchAll(query, queryParams, function(results)
            if (results ~= nil and #results > 0) then
                identifiersExists = tonumber(results[1].count) > 0
            end

            if (not identifiersExists) then
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
            else
                MySQL.Async.execute("UPDATE `user_identifiers` SET `name` = @name, `date` = CURRENT_TIMESTAMP WHERE `identifier` = @identifier AND `license` = @license AND `xbl` = @xbl AND `live` = @live AND `discord` = @discord AND `fivem` = @fivem AND `ip` = @ip", {
                    ['@identifier'] = steamIdentifier,
                    ['@name'] = name,
                    ['@license'] = license,
                    ['@xbl'] = xbl,
                    ['@live'] = live,
                    ['@discord'] = discord,
                    ['@fivem'] = fivem,
                    ['@ip'] = ip,
                })
            end

            deferrals.update(_U('updated_information', Config.Name))

            Citizen.Wait(100)

            deferrals.done()
        end)
    else
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
end