require 'rails_helper'

RSpec.describe "admin/companies/new", :type => :view do
  before(:each) do
    assign(:admin_company, Admin::Company.new(
      :name => "MyString",
      :employees_count => 1,
      :summary => "MyText",
      :website => "MyString"
    ))
  end

  it "renders new admin_company form" do
    render

    assert_select "form[action=?][method=?]", admin_companies_path, "post" do

      assert_select "input#admin_company_name[name=?]", "admin_company[name]"

      assert_select "input#admin_company_employees_count[name=?]", "admin_company[employees_count]"

      assert_select "textarea#admin_company_summary[name=?]", "admin_company[summary]"

      assert_select "input#admin_company_website[name=?]", "admin_company[website]"
    end
  end
end
