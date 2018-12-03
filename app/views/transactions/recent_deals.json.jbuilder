json.success @success
json.response do
  json.array! @transactions do |transaction|
    json.date transaction.date.strftime("%m-%d")
    json.target transaction.target.name
    json.target_id transaction.target.id
    json.value transaction.value
    json.transaction_type transaction.transaction_type.name
    json.buyer_id transaction.buyer_id
    json.seller_id transaction.seller_id
    json.investor transaction.get_company_name(transaction.buyer_id)
    json.seller transaction.get_company_name(transaction.seller_id)
  end
end