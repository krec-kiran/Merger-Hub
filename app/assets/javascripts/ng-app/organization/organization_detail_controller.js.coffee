app = angular.module("MergerhubOrganizationDetailCtlModule", [
  "cgBusy"
])

app.controller "OrganizationDetailCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", "$upload", "$window", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api, $upload, $window) ->

  $scope.company_id = $stateParams.company_id

  getOrganizationDetailSuccess = (results) ->
    if results.success
      $scope.organizationDetail = results.response.company
    return

  getOrganizationDetailError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  getTransactionSuccess = (results) ->
    if results.success
      $scope.transactions = results.response
    return

  getTransactionError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  getTransactionAdvisorSuccess = (results) ->
    if results.success
      $scope.advisorTransactions = results.response
    return

  getTransactionAdvisorError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  $scope.gotoOrganizationJobsDetail = (job_id) ->
    $window.location.href = "/job_portals/" + job_id

  $scope.gotoOrganizationDetail = (company_id) ->
    $window.location.href = "/organization#/"+company_id+"/detail"

  $scope.gotoOrganizationEmployeeDetail = (employee_id) ->
    $window.location.href = "/candidates#/" + employee_id + "/detail"


  $scope.getOrganizationpromise = $api.organizationDetail.get(id: $scope.company_id).$promise.then getOrganizationDetailSuccess, getOrganizationDetailError

  $scope.getTransactionpromise = $api.organizationTransaction.get(id: $scope.company_id).$promise.then getTransactionSuccess, getTransactionError

  $scope.getTransactionpromise = $api.organizationAdvisorTransaction.get(id: $scope.company_id).$promise.then getTransactionAdvisorSuccess, getTransactionAdvisorError

  return
]