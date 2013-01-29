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
    if($(this).data('editable')){
      $(this).editable('destroy');
    }
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
        $(this).removeClass('editable-unsaved');
        var updateUrl = unescape($('#member').data('memberUpdateUrl')).interpolate({id: data.leo_id});
        $('#member').data('memberUpdateUrl', updateUrl);
        $('#member').data('leoId', data.leo_id);
        $('#member').removeAttr('data-member-create-url');
        $('#member').removeData('memberCreateUrl');
        $('.new-member').removeClass('new-member').addClass('edit-member');
        MyApp.initEditMember();
        $('#new-member-btn').hide();
      }
    });
  };

  MyApp.makeEditable(null, $('.new-member'), $('#member').data('memberUpdateUrl'), null);
  $('#new-member-btn').on('click.default', clickHandler);
};