var app = angular.module('Marozi', ['ngResource']);

app.factory('StatisticsService', function($http) {
  return {
    getAgeDistribution: function(clubId) {
      var promise = $http.get('/statistics/clubs/age_distribution/' + clubId)
        .then(function (response) {
          return response.data;
        });
      return promise;
    }
  };
});

app.controller('StatisticsCtrl', function(StatisticsService, $scope) {
  var id = $('#club-overview').data('club-id');
  StatisticsService.getAgeDistribution(id).then(function(data){
    nv.addGraph(function() {
      var chart = nv.models.multiBarChart();
      chart.stacked(true);
      chart.showControls(false);
      chart.x(function(d) { return d.label; });
      chart.y(function(d) { return d.value; });
      chart.yAxis.tickFormat(d3.format('d'));

      d3.select('#age-distribution-chart svg')
        .datum(data)
        .transition().duration(500).call(chart);

      nv.utils.windowResize(chart.update);
      return chart;
    });
  });
});