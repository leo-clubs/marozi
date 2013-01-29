MyApp.disable_menu_item = function() {
  $('ul.nav > li.dropdown > ul.dropdown-menu > li > a[href="#"]').parent().addClass('disabled');
};