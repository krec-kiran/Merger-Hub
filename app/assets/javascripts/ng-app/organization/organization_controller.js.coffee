app = angular.module("MergerhubOrganizationCtlModule", ["cgBusy"])

app.controller "OrganizationCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  $scope.search = {}
  $scope.organization = []
  $scope.search.selectedCompany = ""
  $scope.search.selectedSector = ""
  $scope.search.city= ""
  $scope.search.country= ""
  $scope.search.hiring = false
  $scope.search.fundraising = false

  getOrganizationFilterSuccess = (results) ->
    if results.success
      $scope.sectors = results.response.sectors
      $scope.companies = results.response.companies
      $scope.countries = results.response.countries
      $scope.cities = results.response.cities
    else
      toaster.pop('error', "", "No record found")
    return

  getOrganizationFilterError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  getOrganizationSuccess = (results) ->
    $scope.organization = results.response
    return

  getOrganizationError = (errResponse) ->
    $scope.organization = []
    toaster.pop('error', "", "No record found")
    return

  getParms = () ->
    params = { company_id: $scope.search.selectedCompany, sector_id: $scope.search.selectedSector, city:  $scope.search.city, country: $scope.search.country, hiring: $scope.search.hiring, fundraising: $scope.search.fundraising}
    return params

  $scope.submitOrganization = () ->
    params = getParms()
    $scope.getOrganizationpromise = $api.searchOrganization.get(params).$promise.then getOrganizationSuccess, getOrganizationError
    return

  $scope.clearOrganization = () ->
    $scope.search.selectedCompany = ""
    $scope.search.selectedSector = ""
    $scope.search.city= ""
    $scope.search.country= ""
    $scope.search.hiring = false
    $scope.search.fundraising = false
    $scope.submitOrganization()

  $scope.getOrganizationList = $api.getOrganizationfilter.get().$promise.then getOrganizationFilterSuccess, getOrganizationFilterError

  $scope.submitOrganization()

  $scope.gotoOrganizationDetail = (company_id) ->
    company_url = "#{company_id}/detail"
    $location.path(company_url)
  return
]
