MyApp.convertToHash = function() {
  var hash = {};

  $.each(this, function(key, value){
    if (key.match(/^field/)) {
      hash[key.replace(/^field/, '').toLowerCase()] = value;
    }
  });

  return hash;
};

MyApp.initEditable = function(id, elements, updateUrl, authToken) {
  $.each(elements, function(){
    params = MyApp.convertToHash.apply($(this).data());
    params['pk'] = id;
    params['url'] = updateUrl;
    params['params'] = { authenticity_token: authToken };
    $(this).editable(params);
  });
};