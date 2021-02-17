window.addEventListener("turbolinks:load", () => {
  let search_btn = document.querySelector("#search");
  let experience = document.querySelectorAll?.(".experience__level");
  const select = document.querySelector?.("#q_freelancer_info_category_eq");
  select.addEventListener("change", function (e) {
    fetch(`/job_categories/${e.target.value}.json`)
      .then((response) => response.json())
      .then((data) => {
        let contactSelect = document.querySelector(
          "#q_freelancer_info_subcategory_eq"
        );
        contactSelect.innerHTML = "";

        data.id.map((model, i) => {
          contactSelect.options[i] = new Option(model);
        });
      });
  });
  search_btn.addEventListener("submit", () => {
    experience?.forEach(function (button) {});
  });
});
