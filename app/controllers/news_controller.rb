class NewsController < ApplicationController
  layout :false, only: [:all_sites, :news_entries, :news_filters, :latest_news]

  def index
  end

  def news_sites
    @sites = Site.all
    render_json(true, @sites, 200)
  end

  def news_entries
    @news = []
    @status = false
    @code = 500
    sector_id = params[:sector_id]
    movers = params[:is_movers]
    conditions = ""
    conditions = "sites.is_movers = true" if movers == "Movers and Shakers"
    conditions += " and sector_id = #{sector_id}" if movers == "Movers and Shakers" && sector_id.present?
    conditions += "sector_id = #{sector_id}" if movers != "Movers and Shakers" && sector_id.present?
    @entries = Feed.joins(:site).where(conditions).order("published desc").page(params[:page])
    if @entries && @entries.length > 0
      @status = true
      @code = 200
    end
  end

  def latest_news
    @entries = Feed.includes(:site).order("published desc").limit(10)
    @success = @entries ? true : false
  end

  def news_filters
    @success = true
    @sections = ["Sector", "Movers and Shakers"]
    @sectors = Sector.order("name")
    @geos = ["Americas", "EMEA", "APAC"]
    @size_of_deals = ["50", "50-500m", "500m+"]
  end

  def first_site
    site = Site.first
    render_json(true, site, 200)
  end
end