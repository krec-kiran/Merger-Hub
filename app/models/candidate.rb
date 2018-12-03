class Candidate < ActiveRecord::Base
  attr_accessor :editable
  belongs_to :company
  belongs_to :user

  # validates :email, uniqueness: true

  delegate :name, to: :company, allow_nil: true, prefix: :company

  scope :searchCandidate, -> (candidate_id, company_id, sector_id, title, city) {
    search_str = ""
    if city.kind_of?(Array) && city.include?(nil)
      search_str = "LOWER(city) IS NULL or  LOWER(city) IN (?)"
    else
      search_str = "LOWER(city) IN (?)"
    end
    joins(:company => [:sectors, :company_sectors]).
    where("candidates.id in (?) and LOWER(designation) like '%#{title.downcase}%' and sectors.id in (?) and candidates.company_id in (?)", candidate_id, sector_id, company_id).where(search_str, city).
    order(:name)
    }

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "150x150>" }, :default_url => ActionController::Base.helpers.asset_path('assets/people/missing_:style.jpg')

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def avatar_medium_url
    ApplicationController.helpers.asset_url(avatar.url(:medium))
  end

  def avatar_thumb_url
    ApplicationController.helpers.asset_url(avatar.url(:thumb))
  end

  def is_editable?(current_user)
    editable = false
    editable = true if self.email.downcase == current_user.email.downcase
    self.editable = editable
  end

  def full_address
    [street, city, state, country, pin_code].reject(&:blank?).join(', ')
  end

end
