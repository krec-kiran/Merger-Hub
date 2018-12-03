require 'csv'
namespace :db do

  desc "load Role"
  task :load_roles => :environment do
    Role.create([{ name: "admin" }, { name: "user" }])
    p "Roles created successfully****"
  end

  desc "updated user"
  task :load_user_permission => :environment do
    User.all.each do |user|
      user.is_accept = true
      user.save
    end
  end

  desc "load admin user"
  task :create_admin_user => :environment do
    role_name = Role.find_by(name: "admin")
    User.create(:first_name => "Krec", last_name: "Kiran", email: "admin@example.com", password: "password", role_id: role_name.id)
    p "Admin user created successfully****"
  end

  desc "load Geo"
  task :load_geo => :environment do
    Geo.create([{ name: "Americas" }, { name: "EMEA" }, { name: "APAC" }])
    p "Geo records created successfully****"
  end

  desc "update user's trial detail"
  task :update_user_trial => :environment do
    @users = User.all
    subscription = User.subscriptions.keys.first
    @users.each do |user|
      remaining_days = ((user.created_at + 60.days).to_date - Date.today).round
      user.update_attributes(subscription: subscription, remaining_days: remaining_days)
    end
  end

  desc "update user's trial detail"
  task :update_remaining_days => :environment do
    @users = User.all
    @users.each do |user|
      if user.subscription == "trial"
        remaining_days = ((user.created_at + 60.days).to_date - Date.today).round
        user.update_attribute(:remaining_days, remaining_days)
      end
    end
  end

  desc "load sites"
  task :load_site => :environment do
    feed_sites = [
        { name: "Reuters", url: "http://mf.feeds.reuters.com/reuters/UKBankingFinancial"},
        { name: "The Wall Street Journal", url: "http://www.wsj.com/xml/rss/3_7031.xml"},
        { name: "TechCrunch", url: "http://feeds.feedburner.com/TechCrunch/fundings-exits"}
      ]
    feed_sites.each do |site|
      Site.find_or_create_by(site)
    end
    p "***News sites created****"
  end


  desc "load news sites"
  task :load_news_sites => :environment do
    site_file_path = Rails.root.to_s + "/data_sheets/news_sites_data.csv"
    CSV.foreach(site_file_path, :headers => false) do |row|
      site_name = row[0]
      sector_name = row[1]
      site_url = row[2]
      sector = Sector.find_or_create_by(name: sector_name) if sector_name.present?
      sector.present? ? sector_id = sector.id : sector_id = nil
      site = Site.find_by(url: site_url)
      if site && site.present?
        print site.name, " site already created \n"
      else
        site = Site.create(name: site_name, url: site_url, sector_id: sector.id)
      end
    end
    p "News sites created successfully"
  end

  # desc "load people"
  # task :load_people => :environment do
  #   people_file_path = Rails.root.to_s + "/data_sheets/candidate-100.csv"
  #   CSV.foreach(people_file_path, :headers => false) do |row|
  #     name, email, city, language, year = row[1], row[3], row[7], row[8], row[10]
  #     company_id, sector_id, title_id, vertical_id, coverage_id = nil, nil, nil, nil, nil
  #     coverage_name, company_name, sector_name, title_name, vertical_name = row[9], row[2], row[4], row[5], row[6]
  #     if coverage_name && coverage_name != ""
  #       coverage = Coverage.find_or_create_by(name: coverage_name)
  #       coverage_id = coverage.id if coverage
  #     end
  #     if company_name && company_name != ""
  #       company = Company.find_or_create_by(name: company_name)
  #       company_id = company.id if company
  #     end
  #     if sector_name && sector_name != ""
  #       sector = Sector.find_or_create_by(name: sector_name)
  #       sector_id = sector.id if sector
  #     end
  #     if title_name && title_name != ""
  #       title = Title.find_or_create_by(name: title_name)
  #       title_id = title.id if title
  #     end
  #     if vertical_name && vertical_name != ""
  #       vertical = Vertical.find_or_create_by(name: vertical_name)
  #       vertical_id = vertical.id if vertical
  #     end
  #     candidate = { name: name, email: email, city: city, language: language, year: year }
  #     find_candidate = Candidate.where(candidate).first
  #     unless find_candidate
  #       params = {coverage_id: coverage_id, company_id:company_id, sector_id: sector_id, title_id: title_id, vertical_id: vertical_id}
  #       candidate.merge!(params)
  #       Candidate.create(candidate)
  #     end
  #   end
  #   p "***Candidate created****"
  # end

  # desc "load organizations"
  # task :load_organizations => :environment do
  #   organization_file_path = Rails.root.to_s + "/data_sheets/organisation-100.csv"
  #   CSV.foreach(organization_file_path, :headers => false) do |row|
  #     company_name, sector_name = row[1], row[2]
  #     company_id, sector_id = nil, nil
  #     if company_name && company_name != ""
  #       company = Company.find_or_create_by(name: company_name)
  #       company_id = company.id if company
  #     end
  #     if sector_name && sector_name != ""
  #       sector = Sector.find_or_create_by(name: sector_name)
  #       sector_id = sector.id if sector
  #     end
  #     company_sector = CompanySector.find_or_create_by(company_id: company_id, sector_id: sector_id) if sector_id && company_id
  #   end
  #   p "Organizations created successfully..."
  # end

  # desc "load Transaction"
  # task :load_transactions => :environment do
  #   transaction_file_path = Rails.root.to_s + "/data_sheets/transaction.csv"
  #   CSV.foreach(transaction_file_path, :headers => false) do |row|
  #     tran_date = row[0]

  #     target = row[1]
  #     if target && target != ""
  #       target = Company.find_by(name: target)
  #       target_id = target.id if target
  #     end

  #     sector = row[2]
  #     if sector && sector != ""
  #       sector = Sector.find_by(name: sector)
  #       sector_id = sector.id if sector
  #     end

  #     tran_value = row[3] if row[3] && row[3] != ""
  #     tran_type = row[4]
  #     if tran_type && tran_type != ""
  #       tran_type = TransactionType.find_or_create_by(name: tran_type)
  #       tran_type_id = tran_type.id if tran_type
  #     end
  #     investor = row[5]
  #     if investor && investor != ""
  #       investor = Company.find_by(name: investor)
  #       investor_id = investor.id if investor
  #     end
  #     seller = row[6]

  #     if seller && seller != ""
  #       seller = Company.find_by(name: seller)
  #       seller_id = seller.id if seller
  #     end

  #     transaction = Transaction.find_or_create_by(date: tran_date, target_id: target_id, sector_id: sector_id, value: tran_value, transaction_type_id: tran_type_id, investor_id: investor_id, seller_id: seller_id)
  #   end
  #   p "Transactions created successfully..."
  # end


  desc "load Transaction"
  task :load_data => :environment do
    transaction_file_path = Rails.root.to_s + "/data_sheets/updated_mergr_data.xlsx"
    xlsx = RubyXL::Parser.parse(transaction_file_path)
    create_company_types
    create_companies xlsx
  end

  def create_companies xlsx
    companies_data = xlsx['Companies']
    data = companies_data.extract_data
    data.each_with_index do |row, index|
      unless index == 0 #skip first row
        name = row[0].to_s.strip if !row[0].blank?
        type = row[1].to_s.strip if !row[1].blank?
        sector = row[2].to_s.strip if !row[2].blank?
        revenue = row[3].to_s.strip if !row[3].blank?
        employee = row[4].to_s.strip if !row[4].blank?
        established = row[5].to_s.strip if !row[5].blank?
        street = row[6].to_s.strip if !row[6].blank?
        city = row[7].to_s.strip if !row[7].blank?
        state = row[8].to_s.strip if !row[8].blank?
        country = row[9].to_s.strip if !row[9].blank?
        pincode = row[10].to_s.strip if !row[10].blank?
        phone = row[11].to_s.strip if !row[11].blank?
        website = row[12].to_s.strip if !row[12].blank?
        email = row[13].to_s.strip if !row[13].blank?
        summary = row[14].to_s.strip if !row[14].blank?

        established_date = established if established != ""

        company_type = CompanyType.find_or_create_by({name: type})
        company_type_id = company_type.id if company_type

        params = { name: name, employees_count: employee, established_date: established_date, summary: summary, website: website, email: email, revenue: revenue, company_type_id: company_type_id }
        phone_data = { landline: phone }
        company = Company.find_or_create_by(params)
        company_id = company.id if company

        if sector && sector != ""
          sector = Sector.find_or_create_by(name: sector)
          sector_id = sector.id if sector
        end

        if company
          company_sector = CompanySector.find_or_create_by(company_id: company_id, sector_id: sector_id) if sector_id

          company.phones.find_or_create_by(phone_data)

          location = { street: street, city: city, state: state, country: country, pin_code: pincode, is_headquarter: true, company_id:  company_id }
          company.locations.find_or_create_by(location)
        end
      end
    end
    p "Totally #{Company.count} companies"
    create_MandA_transaction xlsx
  end

  def create_MandA_transaction xlsx
    transaction_data = xlsx['M&A Transaction']
    data = transaction_data.extract_data
    data.each_with_index do |row, index|
      unless index == 0 #skip first row
        company = row[0].to_s.strip if !row[0].blank?
        date = row[1].to_s.strip if !row[1].blank?
        target = row[2].to_s.strip if !row[2].blank?
        value = row[3].to_s.strip if !row[3].blank?
        type = row[4].to_s.strip if !row[4].blank?
        buyer = row[5].to_s.strip if !row[5].blank?
        seller = row[6].to_s.strip if !row[6].blank?
        params, investor_params = get_investor(date, target, type, buyer, seller, value)
        company = Company.find_or_create_by(name: company)
        company_id = company.id if company
        params.merge!(company_id: company_id)

        ma_transaction = MaTransaction.find_or_create_by(params)
        ma_transaction.investors.find_or_create_by(investor_params)
      end
    end
    p "Total #{MaTransaction.count} M&A transactions"
    create_advisor xlsx
    create_candidates xlsx
  end

  def create_advisor xlsx
    advisor_data = xlsx['Advisor']
    data = advisor_data.extract_data
    data.each_with_index do |row, index|
      unless index == 0 #skip first row
        advisor = row[0].to_s.strip if !row[0].blank?
        company = row[1].to_s.strip if !row[1].blank?
        advisor_type = row[2].to_s.strip if !row[2].blank?
        engagement = row[3].to_s.strip if !row[3].blank?

        advisor = Company.find_or_create_by(name: advisor)
        company = Company.find_or_create_by(name: company)

        company_id = company.id if company
        advisor_id = advisor.id if advisor
        params = { advisor_id: advisor_id, company_id: company_id, advisor_type: advisor_type, engagement: engagement }
        advisor = Advisor.find_or_create_by(params)
      end
    end
    p "Advisor records created"
    create_advisor_transaction xlsx
  end

  def create_advisor_transaction xlsx
    advisor_transaction_data = xlsx['Advisor Transaction']
    data = advisor_transaction_data.extract_data
    data.each_with_index do |row, index|
      unless index == 0 #skip first row
        advisor_name = row[0].to_s.strip if !row[0].blank?
        date = row[1].to_s.strip if !row[1].blank?
        client = row[2].to_s.strip if !row[2].blank?
        target = row[3].to_s.strip if !row[3].blank?
        buy_or_sell = row[4].to_s.strip if !row[4].blank?

        company = Company.find_or_create_by(name: advisor_name)
        advisor = Advisor.find_or_create_by(advisor_id: company.id) if company
        client = Company.find_or_create_by(name: client)
        target = Company.find_or_create_by(name: target)

        client_id = client.id if client
        advisor_id = advisor.id if advisor
        target_id = advisor.id if target

        params = { advisor_id: advisor_id, client_id: client_id, target_id: target_id, date: date, buy_or_sell: buy_or_sell }

        advisor = AdvisorTransaction.find_or_create_by(params)
      end
    end
    p "Advisor transaction records created"
  end

  def create_candidates xlsx
  	transaction_data = xlsx['Candidates']
  	data = transaction_data.extract_data
  	data.each_with_index do |row, index|
      unless index == 0 #skip first row
      	company = row[0].to_s.strip if !row[0].blank?
      	name = row[1].to_s.strip if !row[1].blank?
      	designation = row[2].to_s.strip if !row[2].blank?
      	joined = row[3].to_s.strip if !row[3].blank?
      	phone = row[4].to_s.strip if !row[4].blank?
      	board_member = row[5].to_s.strip if !row[5].blank?
      	industry_specialty = row[6].to_s.strip if !row[6].blank?
      	work_history = row[7].to_s.strip if !row[7].blank?
      	education = row[8].to_s.strip if !row[8].blank?
      	bio = row[9].to_s.strip if !row[9].blank?
      	email = row[10].to_s.strip if !row[10].blank?

      	company = Company.find_or_create_by(name: company)
        company_id = company.id if company

      	params = { company_id: company_id, name: name, designation: designation, joined: joined, bio: bio, work_history: work_history, industry_specialty: industry_specialty, board_member: board_member, education: education, phone: phone,  email: email}
      	Candidate.find_or_create_by(params)
    	end
    end
    p "Total #{Candidate.count} candidates"
  end


  def get_investor date, target, type, buyer, seller, value
    target = Company.find_or_create_by(name: target)
    target_id = target.id if target

    type = TransactionType.find_or_create_by(name: type)
    type_id = type.id if type

    if buyer && buyer != ""
	    buyer = Company.find_or_create_by(name: buyer)
	    buyer_id = buyer.id if buyer
  	end
  	if seller && seller != ""
    	seller = Company.find_or_create_by(name: seller)
    	 seller_id = seller.id if seller
  	end

    params = { date: date, target_id: target_id, value: value, transaction_type_id: type_id}
    investor_params = { buyer_id: buyer_id, seller_id: seller_id }

    return params, investor_params
  end

  def create_company_types
    types =[{ name: 'Company' }, { name: 'PE Firm' }, { name: 'Bank' }, { name: 'Law Firm' }]
    types.each do |params|
      target = CompanyType.find_or_create_by(params)
    end
    p "created type of companies"
  end
end