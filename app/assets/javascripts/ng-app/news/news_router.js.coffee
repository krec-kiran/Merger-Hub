app = angular.module("MergerHubNews", [
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.router"
  "templates"
  "ui.bootstrap"
  "toaster"
  "MergerhubSerivce"
  "NewsCtlModule"
  "NewsEntryCtlModule"
  "angularUtils.directives.dirPagination"
])

app.config ['$stateProvider','$urlRouterProvider','$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider.state "News",
    url: "/"
    templateUrl: "news/sites.html"
    controller: "NewsCtr"

  $stateProvider.state "News.Entries",
    url: ":site_id/entries"
    templateUrl: "news/entries.html"
    controller: "NewsEntriesCtr"

  $urlRouterProvider.otherwise('/')
  return
]

app.config ['$httpProvider',($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
app.config ['paginationTemplateProvider', (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dirPagination.html"
]