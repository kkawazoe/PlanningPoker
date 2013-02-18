class Member < ActiveRecord::Base
  attr_accessible :group_id, :name
  belongs_to :group
  has_one :point, :dependent => :destroy
end
