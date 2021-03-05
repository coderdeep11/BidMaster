window.addEventListener("turbolinks:load", (e) => {
  let navElement =
    document.querySelector(".details__tab-freelancer") ||
    document.querySelector(".details__tab-client");
  navElement?.addEventListener("click", (e) => {
    let target = e.target.closest("li");

    if (target.parentElement !== navElement) return;
    if (e.target.nodeName == "LI") e.target.children[0].click();
    let index = target.dataset.tab;
    if ([...navElement.classList].length > 1) {
      [...navElement.classList].forEach((element, i) => {
        if (i > 0) navElement.classList.remove(element);
      });
    }

    navElement.classList.remove(navElement.classList[1]);
    navElement.classList.add(`tab__slider-${+index}`);
  });
});
