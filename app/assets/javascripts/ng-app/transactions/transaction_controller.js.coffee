app = angular.module("MergerhubTransactionCtlModule", ["cgBusy"])

app.controller "TransactionCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", "$window", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api, $window) ->

  $scope.search = {}
  $scope.transaction = []
  $scope.advisor = []
  $scope.firms = []
  $scope.companyList = []
  $scope.search.selectedFromYear = ""
  $scope.search.selectedToYear = ""
  $scope.search.selectedCompany = ""
  $scope.search.selectedSector = ""

  getTransactionFilterSuccess = (results) ->
    if results.success
      $scope.sectors = results.response.sectors
      $scope.companies = results.response.companies
      $scope.years = results.response.years
      $scope.search.selectedFromYear = _.first($scope.years)
      $scope.search.selectedToYear = _.last($scope.years)
      $scope.submitTransaction()
    else
      toaster.pop('error', "", "No record found")
    return

  getTransactionFilterError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  getTransactionSuccess = (results) ->
    if results.success
      $scope.transactions = results.response
      $scope.advisors = results.advisors
      $scope.firms = results.firms
      $scope.companyList = results.companies
    else
      toaster.pop('error', "", "No record found")
    return

  getTransactionError = (errResponse) ->
    $scope.transaction = []
    toaster.pop('error', "", "No record found")
    return

  getParms = () ->
    params = { company_id: $scope.search.selectedCompany, sector_id: $scope.search.selectedSector, from_year: $scope.search.selectedFromYear, to_year: $scope.search.selectedToYear }
    return params

  $scope.submitTransaction = () ->
    if $scope.search.selectedFromYear <= $scope.search.selectedToYear
      params = getParms()
      $scope.getTransactionpromise = $api.searchTransaction.get(params).$promise.then getTransactionSuccess, getTransactionError
      return
    else
      toaster.pop('error', "", "From year should not be greater than To year")

  $scope.clearTransaction = () ->
    $scope.search.selectedFromYear = _.first($scope.years)
    $scope.search.selectedToYear = _.last($scope.years)
    $scope.search.selectedCompany = ""
    $scope.search.selectedSector = ""
    $scope.submitTransaction()

  $scope.redirectOraganizationPage = (company_id) ->
    $window.location.href = "/organization#/"+company_id+"/detail"

  $scope.getTransactionList = $api.getTransactionfilter.get().$promise.then getTransactionFilterSuccess, getTransactionFilterError

  return
]
