angular.module("totalSectorsDirectives", [])

.directive "allSectors", ->
  restrict: "A"
  scope: true
  link: (scope, element, attrs) ->
    scope.$watch( ->
        scope.allSectors
      , ->
        console.log scope.allSectors
        totalTime = new Highcharts.Chart(

          chart:
            renderTo: "all-sectors"
            type: "pie"
            height: 300

          title:
            text: "Sectors"

          subtitle:
            text: pluralize(' company', scope.TotalCompanies, true)

          tooltip:
            pointFormat: "{point.y} {point.company_lbl}"

          plotOptions:
            pie:

              # size: 100,
              # allowPointSelect: true,
              # cursor: 'pointer',
              dataLabels:
                enabled: true
                format: "{point.name}<br>({point.y} {point.company_lbl})"


          # showInLegend: true
          series: [
            type: "pie"
            data: scope.allSectors
          ]
          exporting:
            enabled: false

          credits:
            enabled: false
        )
        return
      )
    return
