class User < ActiveRecord::Base
  serialize :connections
  has_many :votes, dependent: :destroy

  def self.to_csv
    I18n.locale = :en

    CSV.generate do |csv|
      a = %w(ph1 ph2 ph3)

      csv << a.map{ |item| I18n.translate item }

      all.order(name: :asc).group_by{|x|x.votes.count}.sort.each do |group|
        if group.first == 0
          csv << ["Non-voters (#{group.first} votes): #{group.last.count}"]
        else
          p "group.first: #{group.first}"
          csv << ["Voters (#{'vote'.pluralize(group.first)}): #{group.last.count}"]
        end

        group.last.each do |u|
          csv << [u.name, u.email, u.phone_number, u.ip_address]
        end
      end
    end
  end
end
