require 'rails_helper'

RSpec.describe "admin/companies/show", :type => :view do
  before(:each) do
    @admin_company = assign(:admin_company, Admin::Company.create!(
      :name => "Name",
      :employees_count => 1,
      :summary => "MyText",
      :website => "Website"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Website/)
  end
end
