class Location < ActiveRecord::Base
  belongs_to :company
  has_one :job_portal

  def full_address
    [street, city, state, country, pin_code].reject(&:blank?).join(', ')
  end
end
