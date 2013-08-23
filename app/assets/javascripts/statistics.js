var app = angular.module('Marozi', ['angles']);

app.config(function($httpProvider) {
  var authToken = $('meta[name="csrf-token"]').attr('content');
  $httpProvider.defaults.headers.common['X-CSRF-TOKEN'] = authToken;
});

app.controller('MaleFemaleChartCtrl', function($scope, $http, $location) {
  var id = parseId($location.absUrl());
  $http.get('/api/statistics/clubs/'+id+'/gender_ratio').success(function(data){
    $scope.chart = [
      {
        value: data.female,
        color:"#F7464A",
      },
      {
        value: data.male,
        color:"#949FB1",
      },
    ];
  });
});

function parseId(location){
  var id = /(\d+)\/statistics/.exec(location)[1];
  return id;
}

$(document).on('ready page:load', function() {
  angular.bootstrap(document, ['Marozi']);
});
