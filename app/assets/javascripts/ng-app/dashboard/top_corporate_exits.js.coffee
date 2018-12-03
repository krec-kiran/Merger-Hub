app = angular.module("MergerhubCorporateExitModule", ["cgBusy"])

app.controller "corporateExitCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.datatopCorporateExits = [
    {name: 'RSA Insurance Group plc', ytd: 4},
    {name: 'Qbe Insurance Group Ltd.', ytd: 4},
    {name: 'Killick Aerospace', ytd: 4},
    {name: 'Curtiss-Wright Corp.', ytd: 4},
    {name: 'The Procter & Gamble Co.', ytd: 3},
    {name: 'Amaya, Inc.', ytd: 3},
    {name: 'The Royal Bank of Scotland Group plc', ytd: 3},
    {name: 'General Dynamics Corp.', ytd: 3},
    {name: 'Starwood Hotels & Resorts Worldwide, Inc.', ytd: 3},
    {name: 'Acertys Group', ytd: 3}
  ]

  $scope.subTitle = "Exit"
  $scope.title = "Top Corporate - 2015"
  getSectorSuccess = (results) ->
    if results.success
      $scope.topCompanies = []

      angular.forEach $scope.datatopCorporateExits, (value,key) ->
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