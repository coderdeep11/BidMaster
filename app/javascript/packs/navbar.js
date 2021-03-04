window.addEventListener("turbolinks:load", (e) => {
  /*variables */
  let userAvatar = document.querySelector(".user__avatar");
  let conversations = document.querySelector(".conversations__dropdown");
  let navbar = document.querySelector("nav");
  /*******/
  /**event listeners */
  userAvatar?.addEventListener("click", function () {
    userAvatar?.children[1].click();
  });
  conversations?.addEventListener("click", (e) => {
    conversation = e.target.closest(".conversation");

    if (!conversation) return;
    conversation?.children[2].click();
  });
  /*remove-active tab*/
  let removeTabs = (navElements, currentTab) => {
    navElements.forEach((element) => {
      if (element !== currentTab) {
        let childrens = [...element.children];
        let dropdown = childrens[1];
        if (dropdown) dropdown.remove();
      }
    });
  };

  navbar.addEventListener("click", (e) => {
    let nav__element = e.target.closest("li"),
      nav = nav__element?.parentElement.parentElement.nodeName;

    if (!nav__element) return;

    if (nav !== "NAV") return;

    let nav__elements = Array.from(nav__element?.closest("ul").children);
    removeTabs(nav__elements, nav__element);
  });
});
