app = angular.module("MergerhubCandidateCtlModule", ["cgBusy"])

app.controller "CandidatesCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", "$window", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api, $window) ->

  $scope.search = {}
  $scope.people = []
  $scope.search.selectedCandidate = ""
  $scope.search.selectedSector = ""
  $scope.search.selectedCompany = ""
  $scope.search.selectedCity = ""
  $scope.search.selectedTitle = ""

  getPeopleFilterSuccess = (results) ->
    if results.success
      $scope.candidates = results.response.candidates
      $scope.sectors = results.response.sectors
      $scope.cities = results.response.cities
      $scope.companies = results.response.companies
    else
      toaster.pop('error', "", "No record found")
    return

  getPeopleFilterError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  getPeopleSuccess = (results) ->
    $scope.people = results.response.people
    return

  getPeopleError = (errResponse) ->
    $scope.people = []
    toaster.pop('error', "", "No record found")
    return

  getParms = () ->
    candidate_id = $scope.search.selectedCandidate
    sector_id = $scope.search.selectedSector
    company_id = $scope.search.selectedCompany
    city = $scope.search.selectedCity
    params = { candidate_id: candidate_id, sector_id: sector_id, company_id: company_id, title:  $scope.search.selectedTitle, city:  city}
    return params

  $scope.submitPeople = () ->
    params = getParms()
    $scope.getPeoplepromise = $api.searchCandidates.get(params).$promise.then getPeopleSuccess, getPeopleError
    return

  $scope.gotoPeopelDetail = (member_id) ->
    people_url = "#{member_id}/detail"
    $location.path(people_url)

  $scope.clearPeople = () ->
    $scope.search.selectedCandidate = ""
    $scope.search.selectedSector = ""
    $scope.search.selectedCompany = ""
    $scope.search.selectedTitle = ""
    $scope.search.selectedCity = ""
    $scope.submitPeople()

  $scope.redirectOraganizationPage = (company_id) ->
    $window.location.href = "/organization#/"+company_id+"/detail"

  $scope.getPeopleList = $api.getPeoplefilter.get().$promise.then getPeopleFilterSuccess, getPeopleFilterError

  $scope.submitPeople()

  return
]
