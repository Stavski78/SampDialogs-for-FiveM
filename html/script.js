window.addEventListener("message", (e) => {
    const d = e.data;
    if (d.action !== "open") return;

    const dialog = document.getElementById("dialog");
    const content = document.getElementById("content");
    const btnContainer = document.getElementById("buttons");

    content.classList.remove("list");

    dialog.hidden = false;
    document.getElementById("title").innerText = d.title;
    document.getElementById("text").innerText = d.text;
    content.innerHTML = "";
    btnContainer.innerHTML = "";

    if (d.mode === "list") {
        let SelectedIndex = 0;
        const Canceled = -1;

        content.classList.add("list");

        d.items.forEach((item, i) => {
            const div = document.createElement("div");
            div.classList.add("list-item");
            div.innerText = item;

            if(i === SelectedIndex) {
                div.classList.add("selected");
            }
            div.onclick = () => {
                document.querySelector(".list-item.selected")?.classList.remove("selected");
                div.classList.add("selected");
                SelectedIndex = i;
            };

            content.appendChild(div);
        });

        d.buttons.forEach((btn, i) => {
            let b = document.createElement("button");
            b.innerText = btn;
            b.onclick = () => {
                switch(i) {
                    case 0: // Case 0: Clicked button 'Choose'
                        sendResult(SelectedIndex);
                        break;
                    case 1: // Case 1: Clicked button 'Cancel'
                        sendResult(Canceled);
                        break;
                    default:
                        sendResult(Canceled, "For dialog list more than two buttons are not supported.");
                }
            };

            btnContainer.appendChild(b);
        });
    }

    if (d.mode === "msgbox") {
        d.buttons.forEach((btn, i) => {
            let b = document.createElement("button");
            b.innerText = btn;
            b.onclick = () => sendResult(i);
            btnContainer.appendChild(b);
        });
    }

    if (d.mode === "input") {
        let input = document.createElement("input");
        input.placeholder = d.placeholder || "";
        content.appendChild(input);

        d.buttons.forEach((btn, i) => {
            let b = document.createElement("button");
            b.innerText = btn;
            b.onclick = () => sendResult(i, input.value);
            btnContainer.appendChild(b);
        });
    }
    
    if (d.mode === "password") {
        let input = document.createElement("input");
        input.type = "password"
        input.placeholder = d.placeholder || "";
        content.appendChild(input);
        
        d.buttons.forEach((btn, i) => {
            let b = document.createElement("button");
            b.innerText = btn;
            b.onclick = () => sendResult(i, input.value);
            btnContainer.appendChild(b);
        });
    }
});

function sendResult(value, input = null) {
    fetch(`https://${GetParentResourceName()}/dialogResult`, {
        method: "POST",
        body: JSON.stringify({ value, input })
    });

    document.getElementById("dialog").hidden = true;
}