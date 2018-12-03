require 'nokogiri'
class Feed < ActiveRecord::Base
  belongs_to :site
  paginates_per 25



  private
  def self.add_news(news, site)
    if news && news.length != 0
      news.each do |latet_news|
        unless exists? :title => latet_news.title
          create!(
            title: latet_news.title.strip,
            url: latet_news.url,
            published: latet_news.published,
            entry_url: latet_news.entry_id,
            summary:  sanitize_content(latet_news.summary, site.name),
            site_id: site.id,
            category: latet_news.categories,
            image_url: latet_news.image,
            author: latet_news.author
            )
        end
      end
    end
  end

  def self.sanitize_content(content, site_name)
    summary = content
    if site_name == "Reuters"
      summary = ActionController::Base.helpers.strip_tags(summary)
    elsif site_name == "TechCrunch"
      entry = Nokogiri::HTML(summary)
      entry.search('//a[(starts-with(@href, "http://"))]').each do |a|
        a.replace("")
      end
      entry.search("body").each do |cont|
        summary = cont.to_html
      end
    end
    return summary
  end

end
