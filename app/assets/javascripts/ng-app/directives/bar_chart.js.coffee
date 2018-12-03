angular.module("topCompanyGraphDirective", [])

.directive "topCompanyGraph", ->
  restrict: "A"
  scope: true
  link: (scope, element, attrs) ->
    scope.$watch( ->
        scope.topCompanies
      , ->
        totalTime = new Highcharts.Chart(

          chart:
            renderTo: "top-company-graph"
            type: "column"

          title:
            text: scope.title

          subtitle:
            text: scope.subTitle

          xAxis:
            type: "category"

          yAxis:
            title:
              text: "YTD"

          legend:
            enabled: false

          plotOptions:
            series:
              borderWidth: 0,
              dataLabels:
                enabled: true
                format: '{point.y}'

          tooltip:
            headerFormat: '<span style="font-size:11px">{series.name}</span><br>'
            pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y}</b><br/>'

          # showInLegend: true
          series: [
            name: scope.title
            colorByPoint: true
            data: scope.topCompanies
          ]
          exporting:
            enabled: false

          credits:
            enabled: false
        )
        return
      )
    return
