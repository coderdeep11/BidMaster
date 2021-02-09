window.addEventListener("turbolinks:load", () => {
  let event = (e) => {
    let btn = e.target;
    let fBtn = document.querySelector(".f__btn"),
      cBtn = document.querySelector(".c__btn");
    if (
      e.target.classList[0] !== "f__btn" &&
      e.target.classList[0] !== "c__btn" &&
      e.target.classList[0] !== "field_with_errors"
    )
      return;

    btn.children[0].click();
    console.log(btn.children[0].checked);
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
      error.forEach(function (element, i) {
        let validator = element.parentElement.classList[0];
        console.log(validator);

        if (
          i < length - 3 ||
          (length < 5 &&
            validator !== "f__btn" &&
            validator !== "c__btn" &&
            validator !== "role__field")
        ) {
          if (element.previousElementSibling) {
            element.previousElementSibling.setAttribute("style", "color:red");
          }

          let errorMessage = element.nextSibling.textContent;
          element.nextSibling.textContent = "";
          let p = document.createElement("p");
          p.textContent = errorMessage;

          p.insertAdjacentHTML(
            "afterbegin",
            `<i class="fad fa-exclamation-circle"></i>`
          );
          p.classList.add("errors");
          element.parentElement.appendChild(p);
        }
        if (i == length - 3 && validator == "role__field") {
          let roleError = "role can't be empty";
          let childNodes = element.parentElement.childNodes;
          for (i = 0; i < childNodes.length; i++) {
            if (childNodes[i].nodeType == 3) childNodes[i].remove();
          }

          let p = document.createElement("p");
          p.textContent = roleError;

          p.classList.add("errors");
          element.parentElement.appendChild(p);
        }
      });
    }
  }
});
