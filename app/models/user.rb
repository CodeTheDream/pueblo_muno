class User < ActiveRecord::Base
  serialize :connections
  has_many :votes, dependent: :destroy
end
