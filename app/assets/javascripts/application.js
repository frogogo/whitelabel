window.addEventListener("load", () => {
  const menu_button = document.querySelector(".header__burger");
  menu_button.addEventListener("click", () => {
    document.querySelector(".haeder__mob-header").classList.toggle("haeder__mob-header_open");
    document.querySelector(".header__burger").classList.toggle("header__burger_open");
  });
});
