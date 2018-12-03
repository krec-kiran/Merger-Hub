app = angular.module("MergerhubCorporateInvestmentModule", ["cgBusy"])

app.controller "corporateInvestmentCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.datatopCorporateInvestments = [
    {name: 'AssuredPartners, Inc.', ytd: 21},
    {name: 'HUB International Ltd.', ytd: 16},
    {name: 'Arthur J. Gallagher & Co.', ytd: 15},
    {name: 'Patriot National, Inc.', ytd: 13},
    {name: 'Confie Seguros, Inc.', ytd: 13},
    {name: 'Accenture Plc', ytd: 12},
    {name: 'Microsoft Corp.', ytd: 11},
    {name: 'National Financial Partners Corp. (NFP Corp.)', ytd: 11},
    {name: 'Zealot Networks, Inc.', ytd: 9},
    {name: 'Indutrade AB', ytd: 9}
  ]
  $scope.subTitle = "Investments"
  $scope.title = "Top Corporates - 2015"
  getSectorSuccess = (results) ->
    if results.success
      $scope.topCompanies = []

      angular.forEach $scope.datatopCorporateInvestments, (value,key) ->
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