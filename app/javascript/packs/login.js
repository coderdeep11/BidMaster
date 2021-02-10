window.addEventListener("turbolinks:load", () => {
  /******modal function *****/
  ///////******* */
  let modal = (element) => {
    let alert = document.querySelector(element).textContent;

    document.querySelector(element).textContent = "";
    let message = document.createElement("div");

    message.insertAdjacentHTML(
      "beforeend",
      `<div>${alert}</div> <div class="try__again">Try again</div>`
    );

    message.classList.add("alert__popup");
    if (document.querySelector(".login__page")) {
      document
        .querySelector(".login__page")
        .setAttribute("style", " filter: blur(8px);");
    } else {
      document.querySelector("h1").setAttribute("style", " filter: blur(8px);");
    }

    document.querySelector("main").appendChild(message);
    t = setTimeout(function () {
      message.setAttribute("style", "transform:scale(1) translate(50%,-50%)");
      clearInterval(t);
    }, 100);

    /*********when user clicks on login button */
    message.addEventListener("click", (e) => {
      if (e.target.classList[0] !== "try__again") return;
      e.target.parentElement.remove();
      if (document.querySelector(".login__page")) {
        document
          .querySelector(".login__page")
          .setAttribute("style", " filter: blur(0px);");
      } else {
        document
          .querySelector("h1")
          .setAttribute("style", " filter: blur(0px);");
      }
    });
  };
  /****************************/
  if (document.querySelector(".alert").textContent !== "") {
    modal(".alert");
  }

  if (document.querySelector(".notice").textContent !== "") modal(".notice");
});
