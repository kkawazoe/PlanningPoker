class Point < ActiveRecord::Base
  attr_accessible :group_id, :member_id, :value
  belongs_to :member
  belongs_to :member
end
