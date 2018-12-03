json.success @success
json.response do
  json.person do
    json.id @person.id
    json.name @person.name
    json.email @person.email
    json.company_name @person.company_name
    json.company_id @person.company_id
    json.sector_name @person.company.sectors.pluck(:name).join(",")
    json.joined @person.joined
    json.designation @person.designation
    json.bio @person.bio
    json.work_history @person.work_history
    json.industry_specialty @person.industry_specialty
    json.board_member @person.board_member
    json.education @person.education
    json.language @person.language
    json.skills @person.skills
    json.phone @person.phone
    json.city @person.city
    json.location @person.full_address
    json.editable @person.editable
    json.avatar @person.avatar.url(:medium)
  end
end

json.transactions do
  if @person.company && @person.company.id.present?
    transactions = @person.company.ma_transactions.approved
    json.array! transactions  do |transaction|
      json.person_id @person.id
      json.id transaction.id
      json.date transaction.date.strftime("%m/%d/%Y") if transaction.date
      json.target transaction.target.name
      json.target_id transaction.target.id
      json.value transaction.value
      json.sector transaction.target.sectors.first.name
      json.transaction_type transaction.transaction_type.name
      if transaction.investors.present? && transaction.investors.first.buyer_id.present?
        buyer_id = transaction.investors.first.buyer_id
        investor = transaction.get_company_name(buyer_id)
        json.buyer_id buyer_id
        json.investor investor
      end
      if transaction.investors.present? && transaction.investors.first.seller_id.present?
        seller_id = transaction.investors.first.seller_id
        seller = transaction.get_company_name(seller_id)
        json.seller_id seller_id
        json.seller seller
      end
    end
  end
end