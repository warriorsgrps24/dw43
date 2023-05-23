%dw 2.0
output application/json
---
{
"OrderDetails": (payload.OrderDetails - "OrderLineDetails") ++
"OrderLineDetails": flatten(payload.OrderDetails.*OrderLineDetails groupBy $.LineID pluck $ map ((value) -> value map ((value1) -> value1 update {
case .Quantity -> value.Quantity reduce ($ + $$) as String
}
))) distinctBy $.LineID
}
//firstly we can subtract the orderline details from order details and then concatinate orderline details using groupBy function on line id and map the data and using update functionn add the quantity od orders, and use distinct by to reduce similar data.