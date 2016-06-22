class Vote < ActiveRecord::Base
  belongs_to :user
  validates :entree, length: {is: 2}, allow_blank: true
  validates :dessert, length: {is: 2}, allow_blank: true
  validates :drink, length: {is: 2}, allow_blank: true

  before_validation do
    self.entree = entree.size == 2 ? entree : nil if entree
    self.dessert = dessert.size == 2 ? dessert : nil if dessert
    self.drink = drink.size == 2 ? drink : nil if drink
  end

  def add_tallies
    return if tallied
    if entree
      d = Dish.where(priority: "entree", name: entree[0], reach: entree[1])[0]
      d.update(votes: d.votes.succ)
    end
    if dessert
      d = Dish.where(priority: "dessert", name: dessert[0], reach: dessert[1])[0]
      d.update(votes: d.votes.succ)
    end
    if drink
      d = Dish.where(priority: "drink", name: drink[0], reach: drink[1])[0]
      d.update(votes: d.votes.succ)
    end
    update(tallied: true)
  end
end
