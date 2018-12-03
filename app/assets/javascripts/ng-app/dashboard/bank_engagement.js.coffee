app = angular.module("MergerhubBankEngagementModule", ["cgBusy"])

app.controller "BankEngagementCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.bankEngagements = [
    {name: 'Goldman Sachs Investment Banking Division', ytd: 64},
    {name: 'Morgan Stanley', ytd: 55},
    {name: 'Bank of America Merrill Lynch', ytd: 49},
    {name: 'J.P. Morgan Securities LLC', ytd: 43},
    {name: 'Credit Suisse Investment Banking', ytd: 40},
    {name: 'Barclays Investment Bank', ytd: 40},
    {name: 'Citigroup Investment Banking', ytd: 34},
    {name: 'Houlihan Lokey', ytd: 30},
    {name: 'William Blair & Co. LLC', ytd: 30},
    {name: 'Sandler ONeill + Partners LP', ytd: 24}
  ]
  $scope.subTitle = "M&A Engagements"
  $scope.title = "Top Investment Banks - 2015"
  getSectorSuccess = (results) ->
    if results.success
      $scope.topCompanies = []

      angular.forEach $scope.bankEngagements, (value,key) ->
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