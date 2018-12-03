class JobPortal < ActiveRecord::Base
  belongs_to :location, dependent: :destroy
  belongs_to :user
  belongs_to :geo
  belongs_to :company

  accepts_nested_attributes_for :location, :geo, :allow_destroy => true

  scope :accepted, -> { where(is_accept: true) }
end
