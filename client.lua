local ActiveDialog = nil
local Renderers = {}

-- MSGBOX
Renderers.msgbox = function(d)
    SendNUIMessage({
        action = "open",
        mode = "msgbox",
        title = d.title,
        text = d.text,
        buttons = d.buttons or { "OK" }
    })
end

-- LIST
Renderers.list = function(d)
    SendNUIMessage({
        action = "open",
        mode = "list",
        title = d.title,
        text = d.text,
        items = d.options,
        buttons = d.buttons or { "Choose", "Cancel" }
    })
end

-- INPUT
Renderers.input = function(d)
    SendNUIMessage({
        action = "open",
        mode = "input",
        title = d.title,
        text = d.text,
        placeholder = d.placeholder or "",
        buttons = d.buttons or { "OK", "Cancel" }
    })
end

-- PASSWORD
Renderers.password = function(d)
    SendNUIMessage({
        action = "open",
        mode = "password",
        title = d.title,
        text = d.text,
        placeholder = d.placeholder or "",
        buttons = d.buttons or { "OK", "Cancel" }
    })
end

RegisterNetEvent("dialog:open", function(data)
    if not Renderers[data.type] then return end

    ActiveDialog = data.id
    SetNuiFocus(true, true)
    Renderers[data.type](data)
end)

RegisterNUICallback("dialogResult", function(res, cb)
    SetNuiFocus(false, false)

    TriggerServerEvent(
        "dialog:response",
        ActiveDialog,
        res.value,
        res.input
    )

    ActiveDialog = nil
    cb("ok")
end)