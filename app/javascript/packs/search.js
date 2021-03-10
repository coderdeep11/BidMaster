window.addEventListener("turbolinks:load", () => {
  let select__freelancer = document.querySelector?.(
    "#q_bidding_profile_category_eq"
  );
  let select__project = document.querySelector?.("#q_category_eq");
  let project_category = document.querySelector?.("#project_category");
  let freelancer_category = document.querySelector?.(
    "#bidding_profile_category"
  );
  let freelancers = document.querySelector(".freelancers");
  let select = document.querySelector("select");
  let experience__level = document.querySelectorAll(".experience__level");
  let search__filters = [];
  let filter__parameters = document.querySelector(".filter__parameters");
  let searchMode =
    document.querySelector(".search__projects  ") ||
    document.querySelector(".search__freelancers  ");
  /**api to fetch sub categories related to job */
  let fetchCategories = (contactSelect, e) => {
    fetch(`/job_categories/${e.target.selectedIndex - 1}.json`)
      .then((response) => response.json())
      .then((data) => {
        contactSelect.innerHTML = "";

        data.id.map((model, i) => {
          if (i == 0)
            contactSelect.options[i] = new Option("Choose Any", "", true);
          else {
            contactSelect.options[i] = new Option(model);
            contactSelect.options[i].value = model;
          }
        });
      });
  };

  /*dynamic dropdown for job categories(freelancer)*/

  select__freelancer?.addEventListener("change", function (e) {
    fetchCategories(
      document.querySelector("#q_bidding_profile_subcategory_eq"),
      e
    );
  });

  /*dynamic dropdown for job categories(project)*/
  select__project?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#q_subcategory_eq"), e);
  });

  project_category?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#project_subcategory"), e);
  });

  freelancer_category?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#bidding_profile_subcategory"), e);
  });

  freelancers?.addEventListener("click", (e) => {
    let freelancer = e.target.closest(".freelancer");

    if (!freelancer) return;
    freelancer.children[2].click();
  });

  searchMode?.addEventListener("click", (e) => {
    let filters = document.querySelector(".search__filters");

    if (e.target.closest("svg")) filters?.classList.add("show-filter");
    if (
      e.target.closest("toggle__filter") ||
      e.target.closest(".close__filter")
    )
      filters?.classList.remove("show-filter");
  });
  let category = select?.value;
  if (category) search__filters.push(category);
  experience__level.forEach((element) => {
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
