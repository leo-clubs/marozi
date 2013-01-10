disable_menu_item = ->
  $('ul.nav > li.dropdown > ul.dropdown-menu > li').each ->
    if $(this).find('a').attr('href') == '#'
      $(this).addClass('disabled')

$(document).ready(disable_menu_item)
$(window).bind('page:change', disable_menu_item)