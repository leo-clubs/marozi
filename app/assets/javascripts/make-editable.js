MyApp.convertToHash = function() {
  var hash = {};

  $.each(this, function(key, value){
    if (key.match(/^field/)) {
      hash[key.replace(/^field/, '').toLowerCase()] = value;
    }
  });

  return hash;
};

MyApp.makeEditable = function(id, elements, updateUrl, authToken) {
  $.each(elements, function(){
    var params = MyApp.convertToHash.apply($(this).data());
    params['pk'] = id;
    params['url'] = updateUrl;
    params['params'] = { authenticity_token: authToken };
    $(this).editable(params);
  });
};

MyApp.initEditMember = function(){
  MyApp.makeEditable(
    $('#member').data('leoId'),
    $('.edit-member'),
    $('#member').data('memberUpdateUrl'),
    $('meta[name="csrf-token"]').attr('content'));
};

MyApp.initNewMember = function(){
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
        dataType: 'json',
        type: 'post'
      },
      success: function(data, config) {
        var updateUrl = unescape($('#member').data('memberUpdateUrl')).interpolate({id: data.leo_id});
        Turbolinks.visit(updateUrl);
      }
    });
  };

  MyApp.makeEditable(null, $('.new-member'), $('#member').data('memberUpdateUrl'), null);
  $('#new-member-btn').on('click.default', clickHandler);
};

MyApp.initEditOffices = function(){
  $.each($('.office_row'), function(){
    MyApp.makeEditable(
      $(this).data('leoId'),
      $('.edit-office'),
      $(this).data('updateUrl'),
      $('meta[name="csrf-token"]').attr('content'));
  });
};