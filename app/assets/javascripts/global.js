var MyApp = {};

MyApp.initFunction = function(functionReference){
  $(document).ready(functionReference);
  $(window).bind('page:change', functionReference);
};