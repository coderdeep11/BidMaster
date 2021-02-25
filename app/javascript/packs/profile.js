window.addEventListener("turbolinks:load", (e) => {
  let navElement = document.querySelector(".details__tab");
  navElement.addEventListener("click", (e) => {
    let target = e.target.closest("li");

    if (target.parentElement !== navElement) return;
    if (e.target.nodeName == "LI") e.target.children[0].click();
    [...navElement.children].forEach((element) => {
      if (element !== target) element.classList.remove("add__border-bottom");
      target.classList.add("add__border-bottom");
    });
  });
});
