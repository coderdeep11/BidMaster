window.addEventListener("turbolinks:load", (e) => {
  let allProjects = document.querySelector(".projects");
  let userAvatar = document.querySelector(".user__avatar");

  userAvatar?.addEventListener("click", function () {
    userAvatar.children[1].click();
  });

  allProjects?.addEventListener("click", function (e) {
    let project = e.target.closest(".project");

    if (!project) return;

    project.children[3].click();

    t = setTimeout(function () {
      allProjects.setAttribute("style", "transform:translateX(-10%);");
      allProjects.classList.add("disable-click");
      clearTimeout(t);
    }, 300);
  });
});
