String.prototype.interpolate = function (o) {
  return this.replace(/%\{([^\{\}]*)\}/g, function (a, b) {
      var r = o[b];
      return typeof r === 'string' || typeof r === 'number' ? r : a;
    }
  );
};

var MyApp = {};

MyApp.initFunction = function(functionReference) {
  $(document).ready(functionReference);
  $(window).bind('page:change', functionReference);
};