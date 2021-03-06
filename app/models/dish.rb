class Dish < ActiveRecord::Base
  # def self.to_csv
  #   CSV.generate do |csv|
  #     ary = %w(priority reach name price votes)
  #     csv << ary
  #     all.each do |dish|
  #       csv << dish.attributes.values_at(*ary)
  #     end
  #   end
  # end

  # def self.to_csv(lang)
  #   I18n.locale = lang
  #   CSV.generate do |csv|
  #     ary = %w(Priority pages.dish_options.reach pages.dish_options.options pages.results.price pages.results.votes)
  #     ary.map!{|item| I18n.translate item}
  #     csv << ary
  #     all.each do |dish|
  #       data = []
  #       data << I18n.translate("pages.menu.#{dish.priority}")
  #       data << I18n.translate(to_reach dish.reach)
  #       data << I18n.translate(to_name dish.name)
  #       data << "$#{dish.price}"
  #       data << dish.votes
  #       csv << data
  #     end
  #   end
  # end

  def self.to_name(num)
    return 'none' unless num
    num = num.size == 2 ? num[0].to_i : num.to_i
    dishes.find{|k,v| v[:num] == num}[1][:name]
  end

  def self.to_reach(arg)
    return 'none' unless arg
    if Symbol === arg
      reaches[arg][:name]
    else
      num = arg.size == 2 ? arg[1].to_i : arg.to_i
      reaches.find{|k,v| v[:num] == num}[1][:name]
    end
  end

  def self.price(hash)
    priority = hash.keys.first
    return 0 unless hash[priority].to_s.size ==  2
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
        name: 'policy',
        info: 'policy_info'
      },
      growth: {
        num: 2,
        name: 'growth',
        info: 'growth_info'
      },
      growth_and_action: {
        num: 3,
        name: 'growth_action',
        info: 'growth_action_info'
      },
      referrals: {
        num: 4,
        name: 'referrals',
        info: 'referrals_info'
      },
      diversity: {
        num: 5,
        name: 'diversity',
        info: 'diversity_info'
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
        name: 'raleigh',
        info: 'raleigh_info'
      },
      wake: {
        num: 2,
        name: 'wake',
        info: 'wake_info'
      },
      wake_and_more: {
        num: 3,
        name: 'wake_and_more',
        info: 'wake_and_more_info'
      },
      statewide: {
        num: 4,
        name: 'statewide',
        info: 'statewide_info'
      },
      federal: {
        num: 5,
        name: 'federal',
        info: 'federal_info'
      }
    }
  end
end
