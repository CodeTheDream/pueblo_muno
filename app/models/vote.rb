class Vote < ActiveRecord::Base
  belongs_to :user
  validates :entree, length: {is: 2}, allow_blank: true
  validates :dessert, length: {is: 2}, allow_blank: true
  validates :drink, length: {is: 2}, allow_blank: true

  # delegate :name, to: :user, allow_nil: true

  before_validation do
    self.entree = entree.size == 2 ? entree : nil if entree
    self.dessert = dessert.size == 2 ? dessert : nil if dessert
    self.drink = drink.size == 2 ? drink : nil if drink
  end

  def self.to_csv(lang)
    I18n.locale = lang
    CSV.generate do |csv|
      a = %w(contact_info pages.menu.entree entree_reach pages.menu.dessert dessert_reach pages.menu.drink drink_reach connection connection_other)
      a.map!{|item| I18n.translate item}
      csv << a
      all.each do |vote|
        user = vote.user
        contact_info = [user.name, user.email, user.phone_number]
        contact_info.delete('')

        data = []
        data << contact_info.join("\n")
        data << I18n.translate(Dish.to_name vote.entree_name)
        data << I18n.translate(Dish.to_reach vote.entree_reach)
        data << I18n.translate(Dish.to_name vote.dessert_name)
        data << I18n.translate(Dish.to_reach vote.dessert_reach)
        data << I18n.translate(Dish.to_name vote.drink_name)
        data << I18n.translate(Dish.to_reach vote.drink_reach)
        data << user.connections.to_a.map{|x| I18n.translate("pages.start.c#{x}")}.join("\n")
        data << user.connection_other
        csv << data
      end
    end
  end

  def entree_name
    return nil unless entree
    entree[0]
  end

  def entree_reach
    return nil unless entree
    entree[1]
  end

  def dessert_name
    return nil unless dessert
    dessert[0]
  end

  def dessert_reach
    return nil unless dessert
    dessert[1]
  end

  def drink_name
    return nil unless drink
    drink[0]
  end

  def drink_reach
    return nil unless drink
    drink[1]
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

  def dishes
    {entree: entree, dessert: dessert, drink: drink}
  end
end
