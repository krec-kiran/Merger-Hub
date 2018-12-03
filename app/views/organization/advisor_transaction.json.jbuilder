json.success @success
json.response do
  json.array! @advisor_transactions do |transaction|
    json.date transaction.date.strftime("%Y-%m-%d")
    json.client_id transaction.client.id
    json.client transaction.client.name
    json.target_id transaction.target.id
    json.target transaction.target.name
    json.sector transaction.target.sectors.first.name
    json.buy_or_sell transaction.buy_or_sell
  end
end