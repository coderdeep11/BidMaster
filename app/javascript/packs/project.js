window.addEventListener("turbolinks:load", (e) => {
  let allProjects = document.querySelector(".projects");
  let project_post = document.querySelector(".review__proposals-tab");
  let projectModal = document.querySelector(".project__modal");
  let viewYourBid = document.querySelector(".freelancer-placed-bids-on");
  let dropdown = document.querySelector(".project__posted-dropdown");
  let posts = document.querySelector(".projects-posted-by-client");
  let elementPresent = () => {
    return (
      document.querySelector(".freelancer__feed") ||
      document.querySelector(".search__projects")
    );
  };
  /*********/

  let removeStyle = () => {
    document.querySelectorAll(".experience__level").forEach(function (element) {
      if (element.classList[1] == "add__border")
        element.classList.remove("add__border");
    });
  };

  let event = (e) => {
    let btn = e.target;
    if (
      btn.tagName !== "SPAN" &&
      btn.tagName !== "P" &&
      btn.classList[0] !== "experience__level"
    )
      return;
    if (btn.tagName == "DIV") {
      removeStyle();
      btn.classList.add("add__border");
      btn.children[0].click();
    }
    if (btn.tagName == "SPAN") {
      removeStyle();
      btn.parentElement.classList.add("add__border");
      btn.previousElementSibling.click();
    }
    if (btn.tagName == "P") {
      removeStyle();
      btn.parentElement.classList.add("add__border");
      btn.previousElementSibling.previousElementSibling.click();
    }
  };
  document
    .querySelector(".experience-level")
    ?.addEventListener("click", (e) => {
      event(e);
    });
  /*********/
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

  /* */
  posts?.addEventListener("click", function (e) {
    let target = e.target.closest(".project__dropdown-btn"),
      project = e.target.closest("ul");

    if (!project || target) return;

    project.children[0].children[0].click();
  });

  viewYourBid?.addEventListener("click", (e) => {
    let bid = e.target.closest(".each__bid");
    if (!bid) return;
    bid.children[1].click();
  });

  project_post?.children[0].click();

  projectModal?.setAttribute("style", "transform:translateX(0)");
  /**************/
});
