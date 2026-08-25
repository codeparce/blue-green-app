const tabs = document.querySelectorAll("[role='tab']");
const panels = document.querySelectorAll("[role='tabpanel']");

tabs.forEach((tab) => tab.addEventListener("click", () => {
    tabs.forEach((item) => item.setAttribute("aria-selected", item === tab));
    panels.forEach((panel) => panel.hidden = panel.id !== tab.getAttribute("aria-controls"));
}));

document.querySelector("#request-form").addEventListener("submit", async (event) => {
    event.preventDefault();
    const form = event.currentTarget;
    const button = form.querySelector("button[type='submit']");
    const status = document.querySelector("#request-status");
    const responseOutput = document.querySelector("#request-response");
    const method = form.elements.method.value;
    const url = form.elements.url.value;

    button.disabled = true;
    status.textContent = "Enviando...";
    responseOutput.textContent = "";
    try {
        const body = form.elements.body.value.trim();
        const response = await fetch(url, {
            method,
            headers: body ? { "Content-Type": "application/json" } : {},
            body: body && method !== "GET" && method !== "HEAD" ? body : undefined
        });
        const responseText = await response.text();
        status.textContent = `${response.status} ${response.statusText}`;
        try {
            responseOutput.textContent = JSON.stringify(JSON.parse(responseText), null, 2);
        } catch {
            responseOutput.textContent = responseText || "(respuesta vacía)";
        }
    } catch (error) {
        status.textContent = "No se pudo completar la petición";
        responseOutput.textContent = error.message;
    } finally {
        button.disabled = false;
    }
});
