class Donation < ActiveRecord::Base
  attr_accessible :money, :organization_id, :time, :user_id

  belongs_to :organization
  belongs_to :user
end
