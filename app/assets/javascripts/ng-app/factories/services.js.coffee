app = angular.module("MergerhubSerivce", [])

app.factory "$api", ["$resource", ($resource) ->
  # resource declaration
  Candidates: $resource("/admin/candidates/:id.json", null,
    update:
      method: "PUT")
  getCandidateAvatar: $resource("/admin/candidates/:id/get_avatar")
  deleteCandidateAvatar: $resource("/admin/candidates/:id/delete_avatar")

  getSites: $resource("/news_sites.json")
  getSite: $resource("/news/:site_id/entries.json")
  firstSite: $resource("/news/first_site.json")
  latestNews: $resource("/news/latest_news.json")
  liveVacancies: $resource("/job_portals/vacancies.json")
  getNewsFilter: $resource("/news/news_filters.json")



  getPeoplefilter: $resource("/candidates/people_filters.json")
  getOrganizationfilter: $resource("/organization/organization_filters.json")
  getOrganizationSectors: $resource("/organization/organization_sectors.json")
  getTransactionfilter: $resource("/transactions/transaction_filters.json")

  searchCandidates: $resource("/candidates/people_list.json")
  searchOrganization: $resource("/organization/organization_list.json")
  searchTransaction: $resource("/transactions/transaction_list.json")

  personDetail: $resource("/candidates/:id/people_detail.json")
  organizationDetail: $resource("/organization/:id/organization_detail.json")

  recentDeals: $resource("/transactions/recent_deals.json")
  organizationTransaction: $resource("/organization/:id/ma_transaction.json")
  organizationAdvisorTransaction: $resource("/organization/:id/advisor_transaction.json")
]