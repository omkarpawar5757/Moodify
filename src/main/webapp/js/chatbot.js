function sendMessage() {
    const input = document.getElementById("userMsg");
    const msg = input.value.trim();
    if (!msg) return;

    addMessage(msg, "user");
    input.value = "";

    const typing = addMessage("Typing...", "bot");

    fetch("chatbot", {
        method: "POST",
        body: new URLSearchParams({ message: msg })
    })
    .then(res => res.json())
    .then(data => {
        typing.remove();
        addMessage(data.reply, "bot");
    })
    .catch(err => {
        typing.remove();
        addMessage("AI is offline 😔", "bot");
        console.error(err);
    });
}

function addMessage(text, type) {
    const chatBody = document.getElementById("chatBody");
    const div = document.createElement("div");
    div.className = "chat-message " + type;
    div.innerText = text;
    chatBody.appendChild(div);
    chatBody.scrollTop = chatBody.scrollHeight;
    return div;
}
function handleEnter(event) {
    if (event.key === "Enter") {
        event.preventDefault();   // stop form submit
        sendMessage();            // send chat message
    }
}
