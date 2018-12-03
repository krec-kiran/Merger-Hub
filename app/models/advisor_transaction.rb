class AdvisorTransaction < ActiveRecord::Base
  belongs_to :advisor
  belongs_to :client, class_name: "Company"
  belongs_to :target, class_name: "Company"
end
