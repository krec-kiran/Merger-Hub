class Geo < ActiveRecord::Base
  has_many :sites
  has_many :job_portals
end
