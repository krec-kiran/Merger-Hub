app = angular.module("MergerhubFirmInvestmentModule", ["cgBusy"])

app.controller "firmInvestmentCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.datatopFirmInvestments = [
    {name: 'The Carlyle Group', ytd: 23},
    {name: 'Kohlberg Kravis Roberts & Co. LP', ytd: 15},
    {name: 'HIG Private Equity', ytd: 11},
    {name: 'Ardian Private Equity (AXA)', ytd: 11},
    {name: 'Monroe Capital LLC', ytd: 10},
    {name: 'The Riverside Company', ytd: 9},
    {name: 'TPG Capital', ytd: 9},
    {name: 'Lloyds TSB Development Capital Ltd.', ytd: 8},
    {name: 'CVC Capital Partners Ltd.', ytd: 8},
    {name: 'Bridgepoint', ytd: 8}
  ]
  $scope.subTitle = "Investments"
  $scope.title = "Top Firms - 2015"
  getSectorSuccess = (results) ->
    if results.success
      $scope.topCompanies = []

      angular.forEach $scope.datatopFirmInvestments, (value,key) ->
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

  $scope.topFirmsPromise = $api.getOrganizationSectors.get().$promise.then getSectorSuccess, getSectorError
  return
]