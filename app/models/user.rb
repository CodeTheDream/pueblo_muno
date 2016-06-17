class User < ActiveRecord::Base
  validates :email, presence: true
  serialize :connections
end
