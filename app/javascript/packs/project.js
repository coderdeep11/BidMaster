window.addEventListener("turbolinks:load", (e) => {
  document
    .querySelector(".user__avatar")
    .addEventListener("click", function () {
      document.querySelector(".user__avatar").children[1].click();
    });
});
