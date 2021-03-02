window.addEventListener("turbolinks:load", (e) => {
  let allProjects = document.querySelector(".projects");
  let project_post = document.querySelector(".view__project-tab");
  let projectModal = document.querySelector(".project__modal");
  let elementPresent = () => {
    return (
      document.querySelector(".freelancer__feed") ||
      document.querySelector(".search__projects")
    );
  };

  allProjects?.addEventListener("click", function (e) {
    let project = e.target.closest(".project");

    if (!project) return;

    project.children[1].click();
    allProjects.classList.add("disable-click");
    t = setTimeout(function () {
      elementPresent().setAttribute("style", "transform:translateX(-10%);");

      clearTimeout(t);
    }, 300);
  });

  project_post?.children[0].click();
  projectModal?.setAttribute("style", "transform:translateX(0)");
});
