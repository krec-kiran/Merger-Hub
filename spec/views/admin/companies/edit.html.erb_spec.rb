require 'rails_helper'

RSpec.describe "admin/companies/edit", :type => :view do
  before(:each) do
    @admin_company = assign(:admin_company, Admin::Company.create!(
      :name => "MyString",
      :employees_count => 1,
      :summary => "MyText",
      :website => "MyString"
    ))
  end

  it "renders the edit admin_company form" do
    render

    assert_select "form[action=?][method=?]", admin_company_path(@admin_company), "post" do

      assert_select "input#admin_company_name[name=?]", "admin_company[name]"

      assert_select "input#admin_company_employees_count[name=?]", "admin_company[employees_count]"

      assert_select "textarea#admin_company_summary[name=?]", "admin_company[summary]"

      assert_select "input#admin_company_website[name=?]", "admin_company[website]"
    end
  end
end
