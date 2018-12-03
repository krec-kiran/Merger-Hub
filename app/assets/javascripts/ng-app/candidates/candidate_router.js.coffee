app = angular.module("MergerHubPeople", [
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.select"
  "ui.router"
  "ui.bootstrap"
  "toaster"
  "angularFileUpload"
  "templates"
  "MergerhubSerivce"
  "MergerhubCandidateCtlModule"
  "MergerhubPeopleDetailCtlModule"
  "angularUtils.directives.dirPagination"
])

app.config ['$stateProvider','$urlRouterProvider','$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider.state "Candidates",
    url: "/search"
    templateUrl: "candidates/candidates.html"
    controller: "CandidatesCtr"

  $stateProvider.state "CandidateDetail",
    url: "/:member_id/detail"
    templateUrl: "candidates/people_detail.html"
    controller: "CandidateDetailCtr"



  $urlRouterProvider.otherwise('/search')
  return
]

app.config ['$httpProvider',($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
app.config ['paginationTemplateProvider', (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dirPagination.html"
]