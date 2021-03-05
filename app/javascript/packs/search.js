window.addEventListener("turbolinks:load", () => {
  let select__freelancer = document.querySelector?.(
    "#q_freelancer_info_category_eq"
  );
  let select__project = document.querySelector?.("#q_category_eq");
  let project_category = document.querySelector?.("#project_category");
  let freelancers = document.querySelector(".freelancers");

  /**api to fetch sub categories related to job */
  let fetchCategories = (contactSelect, e) => {
    fetch(`/job_categories/${e.target.value}.json`)
      .then((response) => response.json())
      .then((data) => {
        contactSelect.innerHTML = "";

        data.id.map((model, i) => {
          contactSelect.options[i] = new Option(model);
          contactSelect.options[i].value = model;
        });
      });
  };

  /*dynamic dropdown for job categories(freelancer)*/

  select__freelancer?.addEventListener("change", function (e) {
    fetchCategories(
      document.querySelector("#q_freelancer_info_subcategory_eq"),
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

  freelancers?.addEventListener("click", (e) => {
    let freelancer = e.target.closest(".freelancer");

    if (!freelancer) return;
    freelancer.children[2].click();
  });
});
