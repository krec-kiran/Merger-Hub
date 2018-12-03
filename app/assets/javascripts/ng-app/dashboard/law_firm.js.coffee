app = angular.module("MergerhubLawFirmModule", ["cgBusy"])

app.controller "LawFirmCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.lawFirms = [
    {name: 'Kirkland & Ellis LLP', ytd: 78},
    {name: 'Latham & Watkins LLP', ytd: 32},
    {name: 'Jones Day', ytd: 27},
    {name: 'Skadden, Arps, Slate, Meagher & Flom LLP', ytd: 26},
    {name: 'Wachtell, Lipton, Rosen & Katz', ytd: 25},
    {name: 'Goodwin Procter LLP', ytd: 25},
    {name: 'Ropes & Gray LLP', ytd: 25},
    {name: 'Simpson Thacher & Bartlett LLP', ytd: 24},
    {name: 'Weil Gotshal & Manges LLP', ytd: 22},
    {name: 'Sidley Austin LLP', ytd: 20}
  ]
  $scope.subTitle = "M&A Engagements"
  $scope.title = "Top Law Firms - 2015"
  getSectorSuccess = (results) ->
    if results.success
      $scope.topCompanies = []

      angular.forEach $scope.lawFirms, (value,key) ->
        topFirms = {}
        topFirms['name'] = value.name
        topFirms['y'] = value.ytd
        topFirms['drilldown'] = null
        $scope.topCompanies.push(topFirms)
        return
    return

  getSectorError = (errResponse) ->
    toaster.pop('error', "", "Sectors loading failed")
    return

  $scope.companySectorsPromise = $api.getOrganizationSectors.get().$promise.then getSectorSuccess, getSectorError
  return
]