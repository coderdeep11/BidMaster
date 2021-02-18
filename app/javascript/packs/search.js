window.addEventListener("turbolinks:load", () => {
  let select__freelancer = document.querySelector?.(
    "#q_freelancer_info_category_eq"
  );
  let select__project = document.querySelector?.("#q_category_eq");

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
  select__freelancer?.addEventListener("change", function (e) {
    fetchCategories(
      document.querySelector("#q_freelancer_info_subcategory_eq"),
      e
    );
  });
  select__project?.addEventListener("change", function (e) {
    fetchCategories(document.querySelector("#q_subcategory_eq"), e);
  });
});
