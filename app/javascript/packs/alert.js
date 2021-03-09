window.addEventListener("turbolinks:load", () => {
  let notice = document.querySelector(".notice"),
    alert = document.querySelector(".alert");

  let showPopUp = (alertMessage) => {
    let getClass = alertMessage.className;
    document.querySelector("body").setAttribute("style", "overflow:hidden");
    alertMessage.insertAdjacentHTML(
      "beforeend",
      `<div class="close__notice">close</div>`
    );
    alertMessage.parentElement.classList.add("alerts");
    document.querySelector(".alerts")?.addEventListener("click", (e) => {
      let close_btn = e.target.closest(`.${getClass}`);
      document.querySelector("body").setAttribute("style", "overflow-x:hidden");
      if (!close_btn) document.querySelector(".alerts")?.remove();

      if (e.target.className == "close__notice")
        document.querySelector(".alerts").remove();
    });
  };

  if (alert.firstElementChild.textContent !== "") showPopUp(alert);
  if (notice.firstElementChild.textContent !== "") showPopUp(notice);
});
