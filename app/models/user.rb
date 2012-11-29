class User < ActiveRecord::Base
  attr_accessible :age, :city, :email, :firstName, :gender, :income, :job, :lastName, :province

  has_many :donations
  has_many :organizations, :through => :donations
end
