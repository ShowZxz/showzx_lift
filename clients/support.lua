Support = {
    active = false,
    activeRope = nil,
    isOnRope = false,
    lastToggle = 0,
    cooldownEnd = 0,
}

RegisterCommand("lift", function()
    if Support.active then
        errorMsg("You are already in lift mode.")
        return
    end

    if not isSupportStateValid(PlayerPedId()) then
        errorMsg("You are not in a valid state to deploy the rope.")
        return
    end

    if Support.isOnRope then
        errorMsg("You are already on the rope.")
        return
    end

    TriggerServerEvent("showzx_lift:setMode", true)
end)

RegisterCommand("lower", function()
    if not Support.active then
        errorMsg("You are not in lift mode.")
        return
    end

    if not isSupportStateValid(PlayerPedId()) then
        errorMsg("You are not in a valid state to retract the rope.")
        return
    end

    print("Support.isOnRope: ", Support.isOnRope)
    if Support.isOnRope then
        errorMsg("You are on the rope.")
        return
    end

    TriggerServerEvent("showzx_lift:setMode", false)
end)


RegisterNetEvent("showzx_lift:notifyClient", function(isLifting)
    if isLifting then
        TriggerEvent("showzx_lift:enableLiftMode")
        TriggerEvent("showzx_lift:playDeployAnim")
    else
        errorMsg("Lift mode disabled.")
        TriggerEvent("showzx_lift:disableLiftMode")
        TriggerEvent("showzx_lift:playRetractAnim")
    end
end)