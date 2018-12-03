require 'rails_helper'

RSpec.describe "admin/companies/index", :type => :view do
  before(:each) do
    assign(:admin_companies, [
      Admin::Company.create!(
        :name => "Name",
        :employees_count => 1,
        :summary => "MyText",
        :website => "Website"
      ),
      Admin::Company.create!(
        :name => "Name",
        :employees_count => 1,
        :summary => "MyText",
        :website => "Website"
      )
    ])
  end

  it "renders a list of admin/companies" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
  end
end
