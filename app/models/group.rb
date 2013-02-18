class Group < ActiveRecord::Base
  attr_accessible :name
  has_many :members, :dependent => :destroy
  has_many :points, :dependent => :destroy
end
