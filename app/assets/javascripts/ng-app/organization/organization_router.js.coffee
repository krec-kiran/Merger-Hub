app = angular.module("MergerHubOrganization", [
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.select"
  "ui.router"
  "ui.bootstrap"
  "templates"
  "angularFileUpload"
  "toaster"
  "MergerhubSerivce"
  "MergerhubOrganizationCtlModule"
  "MergerhubOrganizationDetailCtlModule"
  "angularUtils.directives.dirPagination"
])

app.config ['$stateProvider','$urlRouterProvider','$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider.state "Organization",
    url: "/search"
    templateUrl: "organization/organization.html"
    controller: "OrganizationCtr"

  $stateProvider.state "OrganizationDetail",
    url: "/:company_id/detail"
    templateUrl: "organization/organization_detail.html"
    controller: "OrganizationDetailCtr"

  $urlRouterProvider.otherwise('/search')
  return
]

app.config ['$httpProvider',($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
app.config ['paginationTemplateProvider', (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dirPagination.html"
]