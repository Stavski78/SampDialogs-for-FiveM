-- ### EXAMPLES ###

RegisterCommand("msgbox", function(source)
    TriggerClientEvent("dialog:open", source, {
        id = 0,
        type = "msgbox",
        title = "Message Box",
        text = "Example of Message Box\n123\naaa",
        -- If not buttons typed - there will be one default button 'OK' for msgbox.
        -- You can put your own buttons inside msgbox with:
        --[[
                buttons = { "Of course", "Okay", "Nope" }
        ]]
    })
end, false)

RegisterCommand("list", function(source)
    TriggerClientEvent("dialog:open", source, {
        id = 1,
        type = "list",
        title = "Super List",
        text = "Please choose an item.",
        options = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" },
        -- Item 6, Item 7... Dialog List can have so much items inside.
        -- Scrollbar activates when height of list is greater than 300px.

        -- If not buttons typed - there will be two default buttons 'Choose' and 'Cancel'.
        -- You can't add add more than two buttons to dialog list.
        -- It's only possible to change the button text for your own.
    })
end, false)

RegisterCommand("input", function(source)
    TriggerClientEvent("dialog:open", source, {
        id = 1,
        type = "input",
        title = "Input",
        text = "Enter the amount of money:",
        placeholder = "1000000", -- not required
        buttons = { "Give", "Take", "Cancel" }

        -- You can add more than two buttons to dialog input.
        -- If not buttons typed - there will be two default buttons 'OK' and 'Cancel'.
    })
end, false)

RegisterCommand("password", function(source)
    TriggerClientEvent("dialog:open", source, {
        id = 1,
        type = "password",
        title = "Password input",
        text = "Enter your password:",
        buttons = { "Log In", "Quit", "Help" }

        -- The same as dialog input.
    })
end, false)

RegisterNetEvent("dialog:response", function(id, value, input)
    print(("Dialog ID: %d | Value: %s | Input: %s | From player: %s"):format(
        id, -- Dialog unique ID
        tostring(value), -- Value: Clicked button or choosen item list
        tostring(input), -- Input: Typed input by user
        GetPlayerName(source)
    ))
end)

-- ###