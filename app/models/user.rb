class User < ActiveRecord::Base
  serialize :connections
  has_many :votes, dependent: :destroy

  def self.to_csv
    CSV.generate do |csv|
      csv << %w(Name Email Phone\ Number IP\ Address)

      all.order(name: :asc).group_by{|x|x.votes.count}.sort.each do |group|
        if group.first == 0
          csv << ["Non-voters (#{group.first} votes): #{group.last.count}"]
        else
          p "group.first: #{group.first}"
          csv << ["Voters (#{group.first 'vote'.pluralize(group.first)}): #{group.last.count}"]
        end

        group.last.each do |u|
          csv << [u.name, u.email, u.phone_number, u.ip_address]
        end
      end
    end
  end
end
