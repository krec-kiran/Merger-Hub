json.success @success
json.response do
  json.array! @transactions do |transaction|
    json.id transaction.id
    json.date transaction.date.strftime("%Y-%m-%d") if transaction.date.present?
    json.target transaction.target.name
    json.target_id transaction.target.id
    json.sector transaction.target.sectors.pluck(:name).join(",")
    json.value transaction.value
    json.transaction_type transaction.transaction_type.name
    json.investor transaction.buyer_names
    json.investor_id transaction.investors.first.seller_id if transaction.investors.first.present?
    json.seller transaction.seller_names
    json.seller_id transaction.investors.first.buyer_id if transaction.investors.first.present?
  end
end