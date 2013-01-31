class Destination < ActiveRecord::Base
  attr_accessible :description, :name

  belongs_to :trip
  has_many :activities

  validates_presence_of :name
end
