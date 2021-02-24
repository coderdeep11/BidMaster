window.addEventListener("turbolinks:load", (e) => {
  let allProjects = document.querySelector(".projects");
  let project_post = document.querySelector(".view__project-tab");
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

  project_post?.children[0].click();
});
