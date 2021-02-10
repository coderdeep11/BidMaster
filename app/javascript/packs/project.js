window.addEventListener("turbolinks:load", () => {
  let removeStyle = () => {
    document.querySelectorAll(".experience__level").forEach(function (element) {
      if (element.classList[1] == "add__border")
        element.classList.remove("add__border");
    });
  };
  let event = (e) => {
    let btn = e.target;
    if (
      btn.tagName !== "B" &&
      btn.tagName !== "SMALL" &&
      btn.classList[0] !== "experience__level"
    )
      return;

    if (btn.tagName == "DIV") {
      removeStyle();
      btn.classList.add("add__border");
      btn.children[0].click();
    }
    if (btn.tagName == "B") {
      removeStyle();
      btn.parentElement.classList.add("add__border");
      btn.previousElementSibling.click();
    }
    if (btn.tagName == "SMALL") {
      removeStyle();
      btn.parentElement.classList.add("add__border");
      btn.previousElementSibling.previousElementSibling.click();
    }
  };
  if (document.querySelector(".experience-level")) {
    document
      .querySelector(".experience-level")
      .addEventListener("click", (e) => {
        event(e);
      });
  }
});
