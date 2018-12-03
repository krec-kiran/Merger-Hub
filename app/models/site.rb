class Site < ActiveRecord::Base
  has_many :feeds
  belongs_to :geo
  belongs_to :sector
end
