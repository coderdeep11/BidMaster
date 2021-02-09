window.addEventListener("turbolinks:load", () => {
  if (
    document.querySelector(".alert").textContent ||
    document.querySelector(".notice").textContent
  ) {
    let alert = document.querySelector(".alert").textContent;

    document.querySelector(".alert").remove();
    let message = document.createElement("div");

    message.insertAdjacentHTML(
      "beforeend",
      `<div>${alert}</div> <div class="try__again">Try again</div>`
    );
    message.classList.add("alert__popup");
    document
      .querySelector(".login__page")
      .setAttribute("style", " filter: blur(8px);");

    document.querySelector("main").appendChild(message);
    t = setTimeout(function () {
      message.setAttribute("style", "transform:scale(1) translate(50%,-50%)");
      clearInterval(t);
    }, 100);
    message.addEventListener("click", (e) => {
      if (e.target.classList[0] !== "try__again") return;
      e.target.parentElement.remove();
      document
        .querySelector(".login__page")
        .setAttribute("style", " filter: blur(0px);");
    });
  }
});
