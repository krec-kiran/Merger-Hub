app = angular.module("MergerhubPeopleDetailCtlModule", [
  "cgBusy"
])

app.controller "CandidateDetailCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", "$upload", "$window", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api, $upload, $window) ->

  $scope.person_id = $stateParams.member_id

  getPersonDetailSuccess = (results) ->
    if results.success
      $scope.personDetail = results.response.person
      $scope.personTransactionDetail = results.transactions
      console.log results.transactions
    else
      toaster.pop('error', "", "No record found")
    return

  getPersonDetailError = (errResponse) ->
    toaster.pop('error', "", "No record found")
    return

  $scope.getPersonpromise = $api.personDetail.get(id: $scope.person_id).$promise.then getPersonDetailSuccess, getPersonDetailError

  $scope.editPeople = (label) ->
    initModal(label)
    return

  initModal = (label)->
    console.log "initModal"
    modalInstance = $modal.open(
      templateUrl: "candidates/_person.html"
      controller: "editPersonModelInstanceCtr"
      size: "lg"
      backdrop: "static"
      resolve:
        personField: ->
          label
        Candidate: ->
          $scope.personDetail
    )
    modalInstance.result.then ((person) ->
      $scope.personDetail = person.response
      return
    ), ->
      return

  $scope.gotoOrganizationDetail = (company_id) ->
    $window.location.href = "/organization#/"+company_id+"/detail"

  $scope.uploadAvatar = ($files) ->
    console.log "upload avatart***"
    console.log $files
    $scope.url = "/admin/candidates/" + $scope.person_id + "/upload_avatar.json"
    console.log $scope.url
    $scope.percent = 0
    if $files and $files.length
      i = 0
      while i < $files.length
        file = $files[i]
        $upload.upload(
          url: $scope.url
          file: file
          fileFormDataName: 'candidate[avatar]'
        ).progress((evt) ->
          $scope.percent = parseInt(100.0 * evt.loaded / evt.total)
          console.log "percent: " + $scope.percent
          return
        ).success((data, status, headers, config) ->
          console.log "success"
          console.log data.response
          $scope.personDetail.avatar = JSON.parse(data.response).avatar_medium_url
          toaster.pop('success', "", "Uploaded avatar.")
          # file is uploaded successfully
          return
        ).error((data, status, headers, config) ->
          console.log data
          toaster.pop('error', "", "File Upload Failed!")
          return
        )
        i++
      return
    return


  return
]

app.controller "editPersonModelInstanceCtr", ["$scope", "$resource", "$location", "$state", "$modal", "toaster", "Candidate", "personField", "$modalInstance", "$api", ($scope, $resource, $location, $state, $modal, toaster, Candidate, personField, $modalInstance, $api) ->

  $scope.candidate = Candidate
  $scope.personField = personField

  $scope.ok = ->
    $modalInstance.close()

  $scope.cancel = ->
    $modalInstance.dismiss('cancel')

  editCandidateSuccess = (candidate) ->
    console.log candidate
    toaster.pop('success', "", "Candidate detail updated successfully.")
    $modalInstance.close(candidate)

  editCandidateError = (errResponse) ->
    console.log errResponse
    toaster.pop('error', "", "Candidate update failed. Try again!")

  $scope.submitPerson = () ->
    $api.Candidates.update( id: $scope.candidate.id , $scope.candidate).$promise.then editCandidateSuccess, editCandidateError

  return
]