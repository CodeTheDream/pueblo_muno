Dish.prices.each do |dish, priorities|
  priorities.each do |priority, ranges|
    ranges.each do |range, price|
      Dish.create(
        name: "#{Dish.dishes[dish][:num]}",
        priority: "#{priority}",
        reach: "#{Dish.places[range]}",
        price: price
      )
    end
  end
end
