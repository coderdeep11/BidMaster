window.addEventListener("turbolinks:load", (e) => {
  let allProjects = document.querySelector(".freelancer__feed");
  let project_post = document.querySelector(".view__project-tab");
  allProjects?.addEventListener("click", function (e) {
    let project = e.target.closest(".project");

    if (!project) return;

    project.children[1].click();
    allProjects.classList.add("disable-click");
    t = setTimeout(function () {
      allProjects.setAttribute("style", "transform:translateX(-10%);");

      clearTimeout(t);
    }, 300);
  });

  project_post?.children[0].click();
});
