class Organization < ActiveRecord::Base
  attr_accessible :description, :impact, :name

  has_many :donations
  has_many :users, :through => :donations
end
