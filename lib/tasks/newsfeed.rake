namespace :rss do
  desc "fetch latest news"
  task :news_feeds => :environment do
    feed_sites = Site.all
    feed_sites.each do |site|
      p "--Cron started at #{Time.now.strftime('%m/%d/%Y %T %p')}--"
      p "** Parsing feeds for the site '#{site[:name]}' **"
      Feedjira::Feed.add_feed_class Feedjira::Parser::RSS
      feed = Feedjira::Feed.fetch_and_parse site[:url]
      news = feed.entries
      Feed.add_news(news, site)
      p "** #{news.length} feeds for the site '#{site.name}' - Done **"
      p "--Cron ended at #{Time.now.strftime('%m/%d/%Y %T %p')}--"
    end
  end

  task :update_exisiting_feeds => :environment do
    require 'nokogiri'
    feeds = Feed.all
    feeds.each do |news|
      summary = Feed.sanitize_content(news.summary, news.site.name)
      news.update(summary: summary)
    end
    p "updated existing news"
  end

end