class Investment < ActiveRecord::Base
  belongs_to :company
  belongs_to :investor_company, class_name: "Company"
end
