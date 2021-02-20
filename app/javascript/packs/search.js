window.addEventListener("turbolinks:load", () => {
  let select__freelancer = document.querySelector?.(
    "#q_freelancer_info_category_eq"
  );
  let select__project = document.querySelector?.("#q_category_eq");

  /**api to fetch sub categories related to job */
  let fetchCategories = (contactSelect, e) => {
    fetch(`/job_categories/${e.target.value}.json`)
      .then((response) => response.json())
      .then((data) => {
        contactSelect.innerHTML = "";

        data.id.map((model, i) => {
          contactSelect.options[i] = new Option(model);
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
});
