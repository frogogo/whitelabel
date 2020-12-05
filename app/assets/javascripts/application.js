window.addEventListener("load", () => {
  const menuButton = document.querySelector(".header__burger");
  const closeMenuLinks = document.querySelectorAll(".header__mob-link");
  var headerMob = document.querySelector(".header__mob-header");
  var headerBurger = document.querySelector(".header__burger");

  menuButton.addEventListener("click", () => {
    headerMob.classList.toggle("header__mob-header_open");
    headerBurger.classList.toggle("header__burger_open");
  });

  closeMenuLinks.forEach((link) => {
    link.addEventListener("click", () => {
      headerMob.className = "header__mob-header";
      headerBurger.className = "header__burger";
    });
  });
});
