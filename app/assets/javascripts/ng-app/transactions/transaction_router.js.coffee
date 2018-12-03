app = angular.module("MergerHubTransaction", [
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.select"
  "ui.router"
  "templates"
  "ui.bootstrap"
  "toaster"
  "MergerhubSerivce"
  "MergerhubTransactionCtlModule"
  "angularUtils.directives.dirPagination"
])

app.config ['$stateProvider','$urlRouterProvider','$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $stateProvider.state "Transaction",
    url: "/search"
    templateUrl: "transactions/transaction.html"
    controller: "TransactionCtr"


  $urlRouterProvider.otherwise('/search')
  return
]

app.config ['$httpProvider',($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
app.config ['paginationTemplateProvider', (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dirPagination.html"
]