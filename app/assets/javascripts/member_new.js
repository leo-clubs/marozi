initNewMember = function(){

  //init editables
  $('.new-member').editable({
      url:  $('#member').data('memberUpdateUrl')
  });

  $('.new-member').on('save.newuser', function(){
      var that = this;
      setTimeout(function() {
          $(that).closest('tr').next().find('.new-member').editable('show');
      }, 200);
  });

  var clickHandler = function(){
    $('.new-member').editable('submit', {
      url: $('#member').data('memberCreateUrl'),
      ajaxOptions: {
        dataType: 'json'
      },
      success: function(data, config) {
        $(this).editable('option', 'pk', data.id);
        $(this).removeClass('editable-unsaved');
        $('#new-member-btn').hide();
      }
    });
  };

  $('#new-member-btn').on('click.default', clickHandler);
};