app = angular.module("MergerHubDashboard", [
  "ngResource"
  "ngAnimate"
  "ngSanitize"
  "ui.select"
  "ui.router"
  "ui.bootstrap"
  "toaster"
  "templates"
  "MergerhubSerivce"
  "MergerhubDashboardCtlModule"
  "MergerhubFirmInvestmentModule"
  "MergerhubFirmExitModule"
  "MergerhubCorporateInvestmentModule"
  "MergerhubCorporateExitModule"
  "MergerhubBankEngagementModule"
  "MergerhubLawFirmModule"
  "topCompanyGraphDirective"
  "angularUtils.directives.dirPagination"
])

app.config ['$stateProvider','$urlRouterProvider','$locationProvider', ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $urlRouterProvider.otherwise('/deals')

  $stateProvider.state "Dashboard",
    abtract: true
    url: "/deals"
    controller: "DashboardCtr"
    templateUrl: "dashboard/dashboard.html"


  $stateProvider.state 'Dashboard.TopFirmInvestment',
    url: "/top_firm_investment"
    views:
      'topFirms':
        templateUrl: 'dashboard/firm_investments.html'
        controller: "firmInvestmentCtr"

  $stateProvider.state 'Dashboard.TopFirmExit',
    url: "/top_firm_exit"
    views:
      'topFirms':
        templateUrl: 'dashboard/firm_exits.html'
        controller: "firmExitCtr"

  $stateProvider.state 'Dashboard.TopCorporateInvestment',
    url: "/top_corporate_investment"
    views:
      'topCorporates':
        templateUrl: 'dashboard/corporate_investments.html'
        controller: "corporateInvestmentCtr"

  $stateProvider.state 'Dashboard.TopCorporateExit',
    url: "/top_corporate_exit"
    views:
      'topCorporates':
        templateUrl: 'dashboard/corporate_exits.html'
        controller: "corporateExitCtr"

  $stateProvider.state 'Dashboard.TopBankEngagement',
    url: "/bank_engagement"
    views:
      'bankEngagement':
        templateUrl: 'dashboard/bank_engagements.html'
        controller: "BankEngagementCtr"

  $stateProvider.state 'Dashboard.TopLawFirm',
    url: "/law_firm"
    views:
      'lawFirm':
        templateUrl: 'dashboard/law_firm.html'
        controller: "LawFirmCtr"

  return
]

app.config ['$httpProvider',($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
app.config ['paginationTemplateProvider', (paginationTemplateProvider) ->
  paginationTemplateProvider.setPath "directives/dirPagination.html"
]