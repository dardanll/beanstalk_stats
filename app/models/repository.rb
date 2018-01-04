class Repository < ActiveRecord::Base
  has_many :changesets
end
