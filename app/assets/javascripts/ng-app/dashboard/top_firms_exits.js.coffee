app = angular.module("MergerhubFirmExitModule", ["cgBusy"])

app.controller "firmExitCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.datatopFirmExits = [
    {name: 'HarbourVest Partners LLC', ytd: 10},
    {name: '3i Private Equity', ytd: 9},
    {name: 'TPG Capital', ytd: 9},
    {name: 'Advent International Corp.', ytd: 7},
    {name: 'Apax Partners', ytd: 6},
    {name: 'Summit Partners', ytd: 6},
    {name: 'The Blackstone Group LP', ytd: 6},
    {name: 'The Carlyle Group', ytd: 6},
    {name: 'Warburg Pincus LLC', ytd: 6},
    {name: 'Inflexion Private Equity Partners LLP', ytd: 6}
  ]

  $scope.subTitle = "Exit"
  $scope.title = "Top Firms - 2015"
  getSectorSuccess = (results) ->
    if results.success
      $scope.topCompanies = []

      angular.forEach $scope.datatopFirmExits, (value,key) ->
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