json.success @success
json.response do
  json.array! @transaction do |transaction|
    json.date transaction.date.strftime("%m/%d/%Y")
    json.target transaction.target.name
    json.target_id transaction.target.id
    json.sector transaction.target.sectors.pluck(:name).join(",")
    json.value transaction.value
    json.transaction_type transaction.transaction_type.name
    json.transaction_id transaction.id
    transaction = MaTransaction.find(transaction.id)
    buyers = transaction.investors.map do |investor|
      if investor.buyer && investor.buyer.present?
        Hash["id", investor.buyer.id, "name", investor.buyer.name]
      end
    end
    json.buyers buyers
    sellers = transaction.investors.map do |investor|
      if investor.seller && investor.seller.present?
        Hash["id", investor.seller.id, "name", investor.seller.name]
      end
    end.compact
    json.sellers sellers
  end
end

json.advisors do
  json.array! @advisors do |advisor|
    json.advisor_name advisor.advisor.name
    json.company_id advisor.advisor_id
    json.type advisor.advisor_type
    json.hq advisor.company.locations.first.full_address
  end
end

json.firms do
  json.array! @firms do |firm|
    json.firm_name firm.name
    json.company_id firm.id
    json.location firm.locations.first.full_address
    if firm.candidates.count > 0
      json.team firm.candidates.count
    else
      json.team "-"
    end
    json.pe_assets firm.revenue
  end
end

json.companies do
  json.array! @companies do |company|
    json.company_name company.name
    json.company_id company.id
    if company.locations.present?
      json.location company.locations.first.full_address
    else
      json.location ""
    end
    if company.sectors.present?
      json.sector company.sectors.first.name
    else
      json.sector ""
    end
    json.revenue company.revenue
  end
end