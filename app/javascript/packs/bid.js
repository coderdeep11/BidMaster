window.addEventListener("turbolinks:load", () => {
  document
    .querySelector(".notifications__modal")
    ?.addEventListener("click", (e) => {
      let element = e.target;
      notification = element?.closest(".notification");
      if (element.className == "btn-primary") return;
      if (!notification) return;
      notification.children[2].click();
    });
});
