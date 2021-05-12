window.addEventListener("turbolinks:load", () => {
  let select__freelancer = document.querySelector?.(
    "#q_bidding_profile_category_eq"
  );
  let select__project = document.querySelector?.("#q_category_eq");
  let project_category = document.querySelector?.("#project_category");
  let freelancer_category = document.querySelector?.("#user_category");
  let freelancers = document.querySelector(".freelancers");
  let users = document.querySelector(".users");
  let select = document.querySelector("select");
  let user_role = document.querySelectorAll(".user__role");
  let search__filters = [];
  let filter__parameters = document.querySelector(".filter__parameters");
  let searchMode = document.querySelector(".search__users");
  /**api to fetch sub categories related to job */
  let fetchCategories = (contactSelect, target) => {
    fetch(`/job_categories/${target.selectedIndex - 1}.json`)
      .then((response) => response.json())
      .then((data) => {
        contactSelect.innerHTML = "";

        data.id.map((model, i) => {
          let subcategory = contactSelect.parentElement.dataset.subcategory;
          if (i == 0)
            contactSelect.options[i] = new Option(
              "Choose Any",
              "",
              false,
              true
            );
          if (subcategory) {
            if (model == subcategory) {
              contactSelect.options[i + 1] = new Option(
                model,
                model,
                false,
                true
              );
            } else contactSelect.options[i + 1] = new Option(model, model);
          } else contactSelect.options[i + 1] = new Option(model, model);
        });
      });
  };

  /*dynamic dropdown for job categories(freelancer)*/

  select__freelancer?.addEventListener("change", function (e) {
    fetchCategories(
      document.querySelector("#q_bidding_profile_subcategory_eq"),
      e.target
    );
  });

  /*dynamic dropdown for job categories(project)*/
  select__project?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#q_subcategory_eq"), e.target);
  });

  project_category?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#project_subcategory"), e.target);
  });
  /******/
  if (project_category?.selectedOptions[0].value) {
    fetchCategories(
      document.querySelector("#project_subcategory"),
      project_category
    );
  }
  /********** */

  freelancer_category?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#user_subcategory"), e.target);
  });

  if (freelancer_category?.selectedOptions[0].value) {
    fetchCategories(
      document.querySelector("#user_subcategory"),
      freelancer_category
    );
  }

  /************************* */
  freelancers?.addEventListener("click", (e) => {
    let freelancer = e.target.closest(".freelancer");

    if (!freelancer) return;
    freelancer.children[2].click();
  });
  users?.addEventListener("click", (e) => {
    let user = e.target.closest(".user");

    if (!user) return;
    user.children[2].click();
  });

  /***************** */
  searchMode?.addEventListener("click", (e) => {
    let filters = document.querySelector(".search__filters");

    if (e.target.closest(".svg__search-filters"))
      filters?.classList.add("show-filter");
    if (
      e.target.closest("toggle__filter") ||
      e.target.closest(".close__filter")
    )
      filters?.classList.remove("show-filter");
  });
  let category = select?.value;
  if (category) search__filters.push(category);
  user_role.forEach((element) => {
    if (element.children[0].checked)
      search__filters.push(element.children[0].value);
  });
  filter__parameters?.insertAdjacentHTML(
    "beforeend",
    `${search__filters
      .map((element) => {
        return `
        <div>${element}
         </div>`;
      })
      .join("")}`
  );
});
