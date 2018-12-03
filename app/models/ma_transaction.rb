class MaTransaction < ActiveRecord::Base
  belongs_to :company
  belongs_to :transaction_type
  belongs_to :target, class_name: "Company"
  has_many :investors, dependent: :destroy

  accepts_nested_attributes_for :investors, :allow_destroy => true

  scope :searchDeals, -> (company_id, sector_id, fromYear, toYear) {
    if fromYear.blank? && toYear.blank?
      search_str = "extract(year from date) = #{Date.today.year}"
    else
      search_str = "extract(year from date) between #{fromYear} and #{toYear}"
    end
    joins(:transaction_type, :target => [:sectors], :investors => [:buyer, :seller]).
    select("target_id, date, array_agg(ma_transactions.id) as ids, value, transaction_type_id").
    where("#{search_str} and target_id in (?) and sectors.id in (?)", company_id, sector_id).group("target_id, value, transaction_type_id, date").order("date desc")
    }

  scope :approved, -> { where(is_approve: true) }
  scope :not_approved, -> { where(is_approve: false) }

  scope :searchTransaction, -> (company_id, sector_id, fromYear, toYear) {
    if fromYear.blank? && toYear.blank?
      search_str = "extract(year from date) = #{Date.today.year}"
    else
      search_str = "extract(year from date) between #{fromYear} and #{toYear}"
    end
    joins(:transaction_type, :target => [:sectors]).
    where("#{search_str} and target_id in (?) and sectors.id in (?)", company_id, sector_id).order("date desc")
    }

  def get_company_name(company_id)
    company = Company.find(company_id)
    name = company.name if company
    return name
  end

  def buyer_names
    investors.map(&:seller).compact.map(&:name).join(",")
  end

  def seller_names
    investors.map(&:buyer).compact.map(&:name).join(",")

  end
end
