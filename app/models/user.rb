class User < ActiveRecord::Base
  has_many :changesets
  has_many :repositories
end
