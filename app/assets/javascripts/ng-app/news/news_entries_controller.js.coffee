app = angular.module("NewsEntryCtlModule", ["cgBusy"])

app.controller "NewsEntriesCtr", ["$scope","$resource","$http", "$location", "$stateParams","$modal", "toaster", "$api", ($scope, $resource, $http, $location, $stateParams, $modal, toaster, $api) ->

  # initialize
  $scope.entries = []
  $scope.site_id = ""
  $scope.totalEntries = 0
  $scope.entriesPerPage = 25
  $scope.pagination = { current: 1 }
  $scope.search = {}
  $scope.sites = []
  $scope.search.selectedSection = ""
  $scope.search.selectedVertical = ""
  $scope.search.selectedGeo = ""
  $scope.search.selectedDeal = ""


  #resources callback
  getNewsFilterSuccess = (results) ->
    if results.success
      $scope.sections = results.response.sections
      $scope.sectors = results.response.sectors
      $scope.geos = results.response.geos
      $scope.size_of_deals = results.response.size_of_deals
    return

  getNewsFilterError = (errResponse) ->
    toaster.pop('error', "", "Loading filters error")
    return

  getSitesSuccess = (results) ->
    $scope.sites = results.response
    return

  getSitesError = (errResponse) ->
    toaster.pop('error', "", "Sites Loading failed")
    return

  #resources callback
  getSiteSuccess = (results) ->
    $scope.entries = results.response.entries
    $scope.totalEntries = results.response.total_page * $scope.entriesPerPage
    return

  getSiteError = (errResponse) ->
    toaster.pop('error', "", "News Loading failed")
    return

  firstSiteSuccess = (results) ->
    $scope.site_id = results.response.id
    return

  firstSiteError = (errResponse) ->
    toaster.pop('error', "", "News Loading failed")
    return

  if not $stateParams.site_id
    $api.firstSite.get().$promise.then firstSiteSuccess, firstSiteError
  else
    $scope.site_id = $stateParams.site_id

  $scope.pageChanged = (newPage) ->
    $scope.entryPage(newPage)

  $scope.sectionChanged = () ->
    if $scope.search.selectedSection != "Sector"
      $scope.search.selectedVertical = ""

  $scope.entrySummary = (summary) ->
    if summary != null
      summary.replace(/<\/?[^>]+>/gi, '')

  getParms = () ->
    params = { page: 1, site_id: $scope.site_id, sector_id: $scope.search.selectedVertical, is_movers: $scope.search.selectedSection }
    return params

  $scope.entryPage = (pageNumber) ->
    params = { page: pageNumber, site_id: $scope.site_id, sector_id: $scope.search.selectedVertical, is_movers: $scope.search.selectedSection }
    $scope.entriesPromise = $api.getSite.get(params).$promise.then getSiteSuccess, getSiteError

  $scope.entryPage(1)

  $scope.clearNews = () ->
    $scope.search.selectedSection = ""
    $scope.search.selectedVertical = ""
    $scope.search.selectedGeo = ""
    $scope.search.selectedDeal = ""
    $scope.entryPage(1)

  $scope.submitNews = () ->
    params = getParms()
    $scope.entriesPromise = $api.getSite.get(params).$promise.then getSiteSuccess, getSiteError

  $api.getNewsFilter.get().$promise.then getNewsFilterSuccess, getNewsFilterError


  # fetch all executives to corresponding employer
  $api.getSites.get().$promise.then getSitesSuccess, getSitesError

  return
]
