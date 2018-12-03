app = angular.module("MergerhubDashboardCtlModule", ["cgBusy"])

app.controller "DashboardCtr", ["$scope","$resource","$http", "$location", "$window", "$state","$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $window, $state,   $stateParams, $modal, toaster, $api) ->

  # initialize
  $scope.entries = []
  $scope.allSectors = []
  $scope.vacancies = []
  $scope.TotalCompanies = 0

  $scope.recentDeals = []

  #resources callback
  getSiteSuccess = (results) ->
    $scope.entries = results.response.entries
    return

  getSiteError = (errResponse) ->
    toaster.pop('error', "", "News Loading failed")
    return

  getliveVacanciesSuccess = (results) ->
    $scope.vacancies = results.response
    return

  getliveVacanciesError = (errResponse) ->
    toaster.pop('error', "", "News Loading failed")
    return

  $scope.latestNewsPromise = $api.latestNews.get().$promise.then getSiteSuccess, getSiteError

  $scope.liveVacanciesPromise = $api.liveVacancies.get().$promise.then getliveVacanciesSuccess, getliveVacanciesError

  recentDealSuccess = (results) ->
    $scope.recentDeals = results.response
    return

  recentDealError = (errResponse) ->
    toaster.pop('error', "", "Loading recent deals failed")
    return

  $scope.recentDealsPromise = $api.recentDeals.get().$promise.then recentDealSuccess, recentDealError


  $scope.firmsInvestments = ->
    $scope.redirecttopFirmInvestmentsPage()
    return

  $scope.corporateInvestments = ->
    $scope.redirecttopCorporateInvestmentsPage()
    return

  $scope.bankMAEngagements = ->
    $scope.redirectBankEngagementPage()
    return

  $scope.lawFirms = ->
    $scope.redirectLawFirmPage()
    return

  $scope.redirecttopFirmInvestmentsPage = ->
    $state.go('Dashboard.TopFirmInvestment')

  $scope.redirecttopFirmExitsPage = ->
    $state.go('Dashboard.TopFirmExit')

  $scope.redirecttopCorporateInvestmentsPage = ->
    $state.go('Dashboard.TopCorporateInvestment')

  $scope.redirecttopCorporateExitPage = ->
    $state.go('Dashboard.TopCorporateExit')

  $scope.redirectBankEngagementPage = ->
    $state.go('Dashboard.TopBankEngagement')

  $scope.redirectLawFirmPage = ->
    $state.go('Dashboard.TopLawFirm')

  $scope.redirectOraganizationPage = (company_id) ->
    $window.location.href = "/organization#/"+company_id+"/detail"


  $scope.isActive = (path) ->
    active = $location.path().includes(path)
    return active

  $scope.redirecttopFirmInvestmentsPage()

  return
]