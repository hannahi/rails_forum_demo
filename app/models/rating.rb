class Rating < ActiveRecord::Base
  has_one :message
  has_one :user

  validates_uniqueness_of :message_id, :scope => :user_id
end
