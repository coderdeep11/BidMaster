window.addEventListener("turbolinks:load", () => {
  /**************** */
  if (document.querySelector(".f__btn")) {
    if (document.querySelector(".f__btn").children[0].checked)
      document.querySelector(".f__btn").classList.add("btn__add-background");
  }
  if (document.querySelector(".f__btn")) {
    if (document.querySelector(".c__btn").children[0].checked)
      document.querySelector(".c__btn").classList.add("btn__add-background");
  }

  /****************** */
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
  }
});
