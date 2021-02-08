window.addEventListener("turbolinks:load", () => {
  let event = (e) => {
    let btn = e.target;
    let fBtn = document.querySelector(".f__btn"),
      cBtn = document.querySelector(".c__btn");
    console.log(e.target);
    if (
      e.target.classList[0] !== "f__btn" &&
      e.target.classList[0] !== "c__btn"
    )
      return;

    btn.children[0].click();
    if (btn.classList[0] == "f__btn") {
      if (cBtn.classList[1] == "btn__add-background")
        cBtn.classList.remove("btn__add-background");
    }
    if (btn.classList[0] == "c__btn") {
      if (fBtn.classList[1] == "btn__add-background")
        fBtn.classList.remove("btn__add-background");
    }

    btn.classList.add("btn__add-background");
  };

  /******** */
  if (document.querySelector(".role__field")) {
    document.querySelector(".role__field").addEventListener("click", (e) => {
      event(e);
    });

    /*****/
    if (document.querySelector(".field_with_errors")) {
      let error = document.querySelectorAll(".field_with_errors");
      let length = error.length;
      console.log(error);
      error.forEach(function (element, i) {
        element.previousElementSibling.setAttribute("style", "color:red");
        let errorMessage = element.nextSibling.textContent;
        element.nextSibling.textContent = "";
        let p = document.createElement("p");
        p.textContent = errorMessage;
        p.classList.add("errors");
        element.parentElement.appendChild(p);
      });
    }
  }
});
