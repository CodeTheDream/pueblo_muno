class User < ActiveRecord::Base
  validates :email, presence: true
  serialize :connections
  has_many :votes
end
