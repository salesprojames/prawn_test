json.array!(@orders) do |order|
  json.extract! order, :id, :product, :qty, :unit_price, :full_price
  json.url order_url(order, format: :json)
end
