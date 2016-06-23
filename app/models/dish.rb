class Dish < ActiveRecord::Base
  def self.to_name(num)
    num = num.to_i
    dishes.find{|k,v| v[:num] == num}[1][:name]
  end

  def self.to_reach(arg)
    if Symbol === arg
      10.times{p arg}
      reaches[arg][:name]
    else
      num = arg.to_i
      reaches.find{|k,v| v[:num] == num}[1][:name]
    end
  end

  def self.price(hash)
    priority = hash.keys.first
    return 0 unless hash[priority].size ==  2
    dish = hash[priority][0]
    range = hash[priority][1]
    dish = dishes.find{|k,v| v[:num] == dish.to_i}[0]
    range = places.find{|k,v| v == range.to_i}[0]
    prices[dish][priority][range]
  end

  def self.dishes
    {
      policy: {
        num: 1,
        name: 'Policy Change'
      },
      growth: {
        num: 2,
        name: 'Individual Growth'
      },
      growth_and_action: {
        num: 3,
        name: 'Individual Growth and Take Action'
      },
      referrals: {
        num: 4,
        name: 'Referrals'
      },
      diversity: {
        num: 5,
        name: 'Cultural Diversity'
      }
    }
  end

  def self.prices
    {
      policy: {
        entree: {
          raleigh: 35,
          wake: 55,
          wake_and_more: 60,
          statewide: 65,
          federal: 70
        },
        dessert: {
          raleigh: 25,
          wake: 40,
          wake_and_more: 45,
          statewide: 50,
          federal: 55
        },
        drink: {
          raleigh: 15,
          wake: 25,
          wake_and_more: 30,
          statewide: 35,
          federal: 40
        }
      },
      growth: {
        entree: {
          raleigh: 25,
          wake: 45,
          wake_and_more: 50,
          statewide: 60
        },
        dessert: {
          raleigh: 15,
          wake: 30,
          wake_and_more: 35,
          statewide: 40
        },
        drink: {
          raleigh: 10,
          wake: 20,
          wake_and_more: 25,
          statewide: 30
        }
      },
      growth_and_action: {
        entree: {
          raleigh: 25,
          wake: 45,
          wake_and_more: 50,
          statewide: 60
        },
        dessert: {
          raleigh: 15,
          wake: 30,
          wake_and_more: 35,
          statewide: 40
        },
        drink: {
          raleigh: 10,
          wake: 20,
          wake_and_more: 25,
          statewide: 30
        }
      },
      referrals: {
        entree: {
          raleigh: 20,
          wake: 35,
          wake_and_more: 40,
          statewide: 45
        },
        dessert: {
          raleigh: 10,
          wake: 20,
          wake_and_more: 25,
          statewide: 30
        },
        drink: {
          raleigh: 5,
          wake: 10,
          wake_and_more: 15,
          statewide: 20
        }
      },
      diversity: {
        entree: {
          raleigh: 20,
          wake: 35,
          wake_and_more: 40,
          statewide: 45
        },
        dessert: {
          raleigh: 10,
          wake: 20,
          wake_and_more: 25,
          statewide: 30
        },
        drink: {
          raleigh: 5,
          wake: 10,
          wake_and_more: 15,
          statewide: 20
        }
      }
    }
  end

  def self.places
    {
      raleigh: 1,
      wake: 2,
      wake_and_more: 3,
      statewide: 4,
      federal: 5
    }
  end

  def self.reaches
    {
      raleigh: {
        num: 1,
        name: 'Raleigh'
      },
      wake: {
        num: 2,
        name: 'Wake County'
      },
      wake_and_more: {
        num: 3,
        name: 'Wake & surrounding counties'
      },
      statewide: {
        num: 4,
        name: 'North Carolina'
      },
      federal: {
        num: 5,
        name: 'United States'
      }
    }
  end
end
